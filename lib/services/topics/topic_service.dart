import 'package:drwhatson/logic/models/quiz.dart';
import 'package:drwhatson/logic/models/topic.dart';

abstract class TopicService {
  Future<List<Topic>> getAllTopics(String locale);
  Future<Quiz> getQuiz(String id, String locale);
}
