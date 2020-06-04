import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/logic/view_models/topics_vm.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/ui/widgets/topic_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopicsScreen extends StatefulWidget {
  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  TopicsViewModel model = serviceLocator<TopicsViewModel>();
  Future<List<Topic>> topics;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    topics = model.getTopics(EasyLocalization.of(context).locale.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text("homePage.topics".tr()),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.pink[200]),
            onPressed: () {
              var _topics = model.getTopics(EasyLocalization.of(context).locale.toString());
              setState(() {
                topics = _topics;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Topic>>(
          future: topics,
          initialData: [],
          builder: (context, snap) {
            if (snap.hasError) return Text("Error: ${snap.error}");
            if (snap.hasData) {
              var topicList = snap.data;
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: topicList.length > 3 ? 2 : 1,
                children: topicList.map((topic) => TopicTile(topic: topic)).toList(),
              );
            } else {
              return Center(
                child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: const CircularProgressIndicator(
                        backgroundColor: Colors.black, valueColor: AlwaysStoppedAnimation(Colors.red))),
              );
            }
          }),
    );
  }

  topicList() {
    return ListView.builder(
      itemCount: model.topics.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: SizedBox(
              width: 60,
              child: Text('${model.topics[index].id}'),
            ),
            title: Text(model.topics[index].title),
            subtitle: Text(model.topics[index].description),
          ),
        );
      },
    );
  }
}
