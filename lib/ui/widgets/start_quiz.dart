import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
          Text(
            quiz.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          Divider(),
          Expanded(
              child: Text(
            quiz.description,
            style: TextStyle(fontSize: 25),
          )),
          RaisedButton(
              elevation: 4,
              padding: EdgeInsets.all(25.0),
              onPressed: state.nextPage,
              color: Colors.green[500],
              hoverColor: Colors.orange,
              highlightColor: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey[800], width: 1, style: BorderStyle.solid)),
              child: Row(
                children: [
                  Icon(Icons.poll),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        'quiz.start'.tr(),
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
}
