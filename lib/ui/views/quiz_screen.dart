// Shared Data
import 'dart:collection';

import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/logic/view_models/topics_vm.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/ui/common/loader.dart';
import 'package:covid_buster_lite/ui/common/progress.dart';
import 'package:covid_buster_lite/ui/widgets/congrats_quiz.dart';
import 'package:covid_buster_lite/ui/widgets/question_quiz.dart';
import 'package:covid_buster_lite/ui/widgets/start_quiz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Answer _selected;
  int _points = 0;
  int _retry = 0;
  HashSet<Answer> answers = new HashSet();
  final PageController controller = PageController();

  get progress => _progress;
  get selected => _selected;
  get points => _points;
  get retry => _retry;

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

  set retry(int retry) {
    _retry = retry;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
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
                onPageChanged: (int idx) =>
                    {state.retry = quiz.retry, state.progress = (idx / (quiz.questions.length + 1))},
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
