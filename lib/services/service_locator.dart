import 'package:drwhatson/logic/view_models/profile_vm.dart';
import 'package:drwhatson/logic/view_models/topics_vm.dart';
import 'package:drwhatson/services/api/api_service.dart';
import 'package:drwhatson/services/api/api_service_impl.dart';
import 'package:drwhatson/services/profile/profile_service.dart';
import 'package:drwhatson/services/profile/profile_service_impl.dart';
import 'package:drwhatson/services/storage/storage_service.dart';
import 'package:drwhatson/services/storage/storage_service_impl.dart';
import 'package:drwhatson/services/topics/topic_service.dart';
import 'package:drwhatson/services/topics/topic_service_impl.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<ProfileService>(
      () => ProfileServiceImpl(),
      instanceName: 'ProfileService');
  serviceLocator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  serviceLocator
      .registerLazySingleton<StorageService>(() => StorageServiceImpl());
  serviceLocator.registerLazySingleton<TopicService>(() => TopicServiceImpl());

  serviceLocator.registerFactory<TopicsViewModel>(() => TopicsViewModel());
}
