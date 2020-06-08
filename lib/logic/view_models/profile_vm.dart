import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/services/topics/topic_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TopicsViewModel extends ChangeNotifier {
  final TopicService _service = serviceLocator<TopicService>();
  List<Topic> _topics = [];

  void loadData(String locale) async {
    await _loadTopics(locale);
    notifyListeners();
  }

  Future<List<Topic>> getTopics(String locale) async {
    return await _service.getAllTopics(locale);
  }

  List<Topic> get topics {
    return _topics;
  }

  Future<void> _loadTopics(String locale) async {
    _topics = await _service.getAllTopics(locale);
  }

  Future<Quiz> getQuiz(String id, String locale) async {
    Quiz q = await _service.getQuiz(id, locale);
    return q;
  }
}
