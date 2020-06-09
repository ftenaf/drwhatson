import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/ui/common/number_slide.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
            child: Text(
              question.question,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.justify,
            ),
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

  getAnswers(Question question, QuizState state, BuildContext context) {
    return question.answers.map((answer) {
      if (answer.type == 'number') {
        return Container(
          height: 120,
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black26,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      state.selected = answer;
                      _bottomSheet(context, answer, state);
                    },
                    child: Icon(state.selected == answer ? Icons.check_circle : Icons.remove_circle_outline, size: 30)),
                NumberSlider(
                  answer: answer,
                  onNumberChange: (int val) {
                    answer.value = val.toString();
                  },
                )
              ],
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
                        style: TextStyle(fontSize: 25),
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

  _bottomSheet(BuildContext context, Answer opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                !correct && state.retry > 0
                    ? "Le quedan " + (state.retry - 1).toString() + " intentos: " + opt.detail
                    : opt.detail,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  child:
                      FlareActor("assets/" + (correct ? "right.flr" : "wrong.flr"), animation: "go", fit: BoxFit.fill)),
              FlatButton(
                color: correct ? Colors.green : Colors.red,
                child: Text(
                  'quiz.continue'.tr(),
                  style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold, fontSize: 45),
                ),
                onPressed: () {
                  state.retry = (state.retry - 1);
                  if (correct || state.retry < 1) {
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
}
