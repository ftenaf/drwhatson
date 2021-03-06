import 'package:drwhatson/logic/models/topic.dart';

abstract class StorageService {
  Future cacheTopicsData(List<Topic> data);

  Future<List<Topic>> getTopics(String locale);

  Future<List<Topic>> getFavoriteTopics();

  Future saveFavoriteTopics(List<Topic> data);

  Future<bool> isExpiredCache();
}
