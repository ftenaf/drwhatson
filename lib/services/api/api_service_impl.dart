import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/api/api_service.dart';
import 'package:covid_buster_lite/services/common/utils.dart';

class ApiServiceImpl implements ApiService {
  @override
  Future<List<Topic>> fetchTopics() async {
    String url =
        'https://raw.githubusercontent.com/ftenaf/covid_buster_lite/master/assets/quizzes.json?token=AADNMWSAPN24PSPZS3NDYIS6XVXXS';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final x = deserializeTopics(jsonData);
      return x;
    } else {
      return null;
    }
  }
}
