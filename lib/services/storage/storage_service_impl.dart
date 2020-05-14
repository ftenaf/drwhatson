import 'dart:convert';

import 'package:covid_buster_lite/logic/models/topic.dart';
import 'package:covid_buster_lite/services/common/utils.dart';
import 'package:covid_buster_lite/services/storage/storage_service.dart';
import 'package:flutter/services.dart';

class StorageServiceImpl implements StorageService {
  static const String sharedPrefTopicsKey = 'topic_key';
  static const String sharedPrefLastCacheTimeKey = 'cache_time_key';
  @override
  Future cacheTopicsData(List<Topic> data) {
    // TODO: to be implemented
    return null;
  }

  @override
  Future<List<Topic>> getTopics() async {
    String data = await rootBundle.loadString('assets/quizzes.json');

    List<Topic> topics = deserializeTopics(data);
    return Future<List<Topic>>.value(topics);
  }

  @override
  Future<List<Topic>> getFavoriteTopics() {
    // TODO: implement getFavoriteTopics
    //throw UnimplementedError();
  }

  @override
  Future saveFavoriteTopics(List<Topic> data) {
    // TODO: implement saveFavoriteTopics
    //throw UnimplementedError();
  }

  @override
  Future<bool> isExpiredCache() {
    // TODO: implement isExpiredCache
    //throw UnimplementedError();
  }
}
