import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/ui/utils/image.dart';
import 'package:covid_buster_lite/ui/views/topic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;

  const TopicTile({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: topic.id,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.blue[800],
          elevation: 4,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: getImage(topic.img, context, BoxFit.contain),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                            child: Text(
                          topic.title,
                          style: TextStyle(
                              height: 1.2, fontWeight: FontWeight.bold, fontSize: 40, color: Colors.grey[200]),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        )),
                      ),
                    ),
                  ],
                ),
                //TopicProgress(topic: topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
