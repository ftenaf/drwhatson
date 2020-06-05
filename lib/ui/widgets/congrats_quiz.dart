import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expressions/expressions.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
          Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: FlareActor("assets/success.flr", animation: "explode", fit: BoxFit.none)),
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
