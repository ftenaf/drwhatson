import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/ui/utils/image.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homePage.back".tr()),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: ListView(children: [
            Hero(
              tag: topic.id,
              child: getImage(topic.img, context, BoxFit.contain),
            ),
            Text(
              topic.title,
              textAlign: TextAlign.right,
              style: TextStyle(height: 2, fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue[700]),
            ),
            QuizList(topic: topic)
          ])),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;

  QuizList({Key key, this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: Colors.blue[200],
        elevation: 15,
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizScreen(quizId: quiz.id),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(4),
            child: ListTile(
              hoverColor: Colors.blue,
              focusColor: Colors.blue,
              title: Text(
                quiz.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      );
    }).toList());
  }
}
