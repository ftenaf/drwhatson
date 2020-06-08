import 'dart:async';

import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/api/api_service.dart';
import 'package:covid_buster_lite/services/common/utils.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl implements ApiService {
  @override
  Future<List<Topic>> fetchTopics(String locale) async {
    String url = 'https://raw.githubusercontent.com/ftenaf/covid_buster_lite/master/assets/data/quizzes_${locale}.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Topic> topics = deserializeTopics(response.body);
      return Future<List<Topic>>.value(topics);
    } else {
      return null;
    }
  }
}
