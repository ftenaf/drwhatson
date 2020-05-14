import 'package:covid_buster_lite/logic/models/topic.dart';

abstract class ApiService {
  Future<List<Topic>> fetchTopics();
}
