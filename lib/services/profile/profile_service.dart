import 'package:covid_buster_lite/logic/models/profile.dart';

abstract class ProfileService {
  Future<int> createProfile();
  Future<Profile> getProfile();
  Future<void> saveProfile(Profile profile);
}
