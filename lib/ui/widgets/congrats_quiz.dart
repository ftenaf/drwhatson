import 'package:covid_buster_lite/logic/view_models/topics_vm.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CongratsPage extends StatelessWidget {
  final TopicsViewModel topicsVM;

  CongratsPage({this.topicsVM});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    //print(state.answers.map((a) => a.).reduce((value, element) => value));
    var totalPoints = state.answers.map((e) => topicsVM.getAnswerPoints(e)).reduce((value, element) => value + element);
    String result = topicsVM.getResult(totalPoints);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'quiz.congrats',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ).tr(
              namedArgs: {'title': topicsVM.activeQuiz.title, 'totalPoints': totalPoints.toString(), 'result': result}),
          Divider(),
          Text(
            'quiz.result',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 45),
          ).tr(namedArgs: {'result': result}),
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
            label: Text(
              'quiz.markcompleted'.tr(),
              style: TextStyle(fontSize: 30),
            ),
            onPressed: () {
              _updateUserReport();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  _updateUserReport() {
    print(topicsVM.activeQuiz.questions.length);
    //(q) { q.answers.map((a){})}));
  }
}
