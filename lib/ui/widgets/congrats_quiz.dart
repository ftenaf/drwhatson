import 'package:drwhatson/logic/view_models/topics_vm.dart';
import 'package:drwhatson/ui/views/quiz_screen.dart';
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
    var totalPoints = state.answers
        .map((e) => topicsVM.getAnswerPoints(e))
        .reduce((value, element) => value + element);
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
          ).tr(namedArgs: {
            'title': topicsVM.activeQuiz.title,
            'totalPoints': totalPoints.toString(),
            'result': result
          }),
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
              child: FlareActor("assets/success.flr",
                  animation: "explode", fit: BoxFit.none)),
          Divider(),
          RaisedButton(
              elevation: 4,
              padding: EdgeInsets.all(25.0),
              onPressed: () {
                _updateUserReport();
                Navigator.pop(context);
              },
              color: Colors.green[500],
              hoverColor: Colors.orange,
              highlightColor: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      color: Colors.grey[800],
                      width: 1,
                      style: BorderStyle.solid)),
              child: Row(
                children: [
                  Icon(Icons.check),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        'quiz.markcompleted'.tr(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  _updateUserReport() {
    print(topicsVM.activeQuiz.questions.length);
    //(q) { q.answers.map((a){})}));
  }
}
