import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/logic/models/topic.dart';

abstract class TopicService {
  Future<List<Topic>> getAllTopics(String locale);
  Future<Quiz> getQuiz(String id, String locale);
}
