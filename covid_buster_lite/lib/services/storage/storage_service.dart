import 'package:covid_buster_lite/logic/models/topic.dart';

abstract class StorageService {
  Future cacheTopicsData(List<Topic> data);

  Future<List<Topic>> getTopics();

  Future<List<Topic>> getFavoriteTopics();

  Future saveFavoriteTopics(List<Topic> data);

  Future<bool> isExpiredCache();
}
