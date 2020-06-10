import 'dart:convert';

import 'package:drwhatson/logic/models/topic.dart';

List<Topic> _topicsFromJson(List<dynamic> data) {
  List<Topic> topics = new List();
  topics = data.map((e) => Topic.fromMap(e)).toList();
  return topics;
}

List<Topic> deserializeTopics(String data) {
  List<Topic> topics = new List();
  final jsonData = json.decode(data);
  topics = _topicsFromJson(jsonData);
  return topics;
}
