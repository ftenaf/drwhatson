import 'dart:async';

import 'package:drwhatson/logic/models/topic.dart';
import 'package:drwhatson/services/api/api_service.dart';
import 'package:drwhatson/services/common/utils.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl implements ApiService {
  @override
  Future<List<Topic>> fetchTopics(String locale) async {
    String url =
        'https://raw.githubusercontent.com/ftenaf/drwhatson/master/assets/data/quizzes_${locale}.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Topic> topics = deserializeTopics(response.body);
      return Future<List<Topic>>.value(topics);
    } else {
      return null;
    }
  }
}
