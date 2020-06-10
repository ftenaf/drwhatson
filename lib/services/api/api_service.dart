import 'package:drwhatson/logic/models/topic.dart';

abstract class ApiService {
  Future<List<Topic>> fetchTopics(String locale);
}
