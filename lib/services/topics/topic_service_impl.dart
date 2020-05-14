import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/api/api_service.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/services/storage/storage_service.dart';
import 'package:covid_buster_lite/services/topics/topic_service.dart';

class TopicServiceImpl implements TopicService {
  ApiService _apiService = serviceLocator<ApiService>();
  StorageService _storageService = serviceLocator<StorageService>();

  @override
  Future<List<Topic>> getAllTopics(String locale) async {
    List<Topic> topics = await _apiService.fetchTopics(locale);
    if (topics == null) {
      topics = await _storageService.getTopics(locale);
    } else {
      //TODO detect version changes among storaged and online versions
    }
    return topics;
  }
}
