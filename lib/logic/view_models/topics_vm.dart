import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/services/topics/topic_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TopicsViewModel extends ChangeNotifier {
  final TopicService _service = serviceLocator<TopicService>();
  List<Topic> _topics = [];

  void loadData() async {
    await _loadTopics();
    notifyListeners();
  }

  Future<List<Topic>> getTopics() async {
    return await _service.getAllTopics();
  }

  List<Topic> get topics {
    return _topics;
  }

  Future<void> _loadTopics() async {
    _topics = await _service.getAllTopics();
  }
}
