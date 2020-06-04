// Shared Data
import 'dart:collection';

import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/logic/view_models/topics_vm.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/ui/common/loader.dart';
import 'package:covid_buster_lite/ui/common/number_slide.dart';
import 'package:covid_buster_lite/ui/common/progress.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Answer _selected;
  int _points = 0;
  HashSet<Answer> answers = new HashSet();
  final PageController controller = PageController();

  get progress => _progress;
  get selected => _selected;
  get points => _points;

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Answer newValue) {
    _selected = newValue;
    answers.add(_selected);
    notifyListeners();
  }

  set points(int newPoints) {
    _points = newPoints;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

class QuizScreen extends StatelessWidget {
  final TopicsViewModel model = serviceLocator<TopicsViewModel>();
  QuizScreen({this.quizId});

  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder(
        future: model.getQuiz(quizId, EasyLocalization.of(context).locale.toString()),
        builder: (BuildContext context, AsyncSnapshot snap) {
          var state = Provider.of<QuizState>(context);
          if (!snap.hasData || snap.hasError) {
            return LoadingScreen();
          } else {
            Quiz quiz = snap.data;
            return Scaffold(
              appBar: AppBar(
                title: AnimatedProgressbar(value: state.progress),
                leading: IconButton(
                  icon: Icon(Icons.backspace),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) => state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz);
                  } else if (idx == quiz.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  final PageController controller;

  StartPage({this.quiz, this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline1),
          Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: state.nextPage,
                label: Text('quiz.start'.tr()),
                icon: Icon(Icons.poll),
                color: Colors.green,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;

  CongratsPage({this.quiz});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    //print(state.answers.map((a) => a.).reduce((value, element) => value));
    var totalPoints = state.answers.map((e) => getAnswerPoints(e)).reduce((value, element) => value + element);
    String result = getResult(quiz, totalPoints);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'quiz.congrats',
            textAlign: TextAlign.center,
          ).tr(namedArgs: {'title': quiz.title, 'totalPoints': totalPoints.toString(), 'result': result}),
          Divider(),
          Image.asset('assets/img/congratulations.gif'),
          Divider(),
          FlatButton.icon(
            color: Colors.green,
            icon: Icon(Icons.check),
            label: Text('quiz.markcompleted'.tr()),
            onPressed: () {
              _updateUserReport(quiz);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  _updateUserReport(Quiz quiz) {
    print(quiz.questions.length);
    //(q) { q.answers.map((a){})}));
  }

  int getAnswerPoints(Answer e) {
    if (e.formula == null || e.formula.isEmpty) {
      return e.points;
    } else {
      Expression expression = Expression.parse(e.formula);
      var ctx;
      if (e.value.contains('.')) {
        ctx = {"x": int.parse(e.value.substring(0, e.value.indexOf(".")))};
      } else {
        ctx = {"x": int.parse(e.value)};
      }

      final evaluator = const ExpressionEvaluator();
      var r = evaluator.eval(expression, ctx);
      return r;
    }
  }

  String getResult(Quiz quiz, int totalPoints) {
    for (final result in quiz.results) {
      Expression expression = Expression.parse(result.formula);
      var ctx = {"x": totalPoints};
      final evaluator = const ExpressionEvaluator();
      var r = evaluator.eval(expression, ctx);
      if (r) return result.result;
    }
    return "";
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;

  QuestionPage({this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.question),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getAnswers(question, state, context),
          ),
        )
      ],
    );
  }

  _bottomSheet(BuildContext context, Answer opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                opt.detail,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              FlatButton(
                color: correct ? Colors.green : Colors.red,
                child: Text(
                  correct ? 'quiz.right'.tr() : 'quiz.tryagain'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  getAnswers(Question question, QuizState state, BuildContext context) {
    return question.answers.map((answer) {
      if (answer.type == 'number') {
        return Container(
          height: 120,
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black26,
          child: InkWell(
            onTap: () {
              state.selected = answer;
              _bottomSheet(context, answer, state);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(state.selected == answer ? Icons.check_circle : Icons.remove_circle_outline, size: 30),
                  NumberSlider(
                    answer: answer,
                    onNumberChange: (int val) {
                      answer.value = val.toString();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          height: 90,
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black26,
          child: InkWell(
            onTap: () {
              state.selected = answer;
              _bottomSheet(context, answer, state);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(state.selected == answer ? Icons.check_circle : Icons.remove_circle_outline, size: 30),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        answer.value,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }).toList();
  }
}
