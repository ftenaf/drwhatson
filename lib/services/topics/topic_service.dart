import 'package:covid_buster_lite/logic/models/topic.dart';

abstract class TopicService {
  Future<List<Topic>> getAllTopics(String locale);
}
