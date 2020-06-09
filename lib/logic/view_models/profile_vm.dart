import 'package:covid_buster_lite/logic/models/profile.dart';
import 'package:covid_buster_lite/services/profile/profile_service.dart';
import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ProfileViewModel with ChangeNotifier {
  final ProfileService _service = serviceLocator.get(instanceName: 'ProfileService');
  Profile _profile;

  Future<Profile> getProfile() async {
    Profile p = await _service.getProfile();
    _profile = p;
    notifyListeners();
    return p;
  }

  Future<void> saveProfile(Profile profile) async {
    await _service.saveProfile(profile);
    _profile = profile;
    notifyListeners();
  }

  Profile get profile {
    return _profile;
  }

  double get points {
    double pts = 0;
    if (_profile != null) {
      pts = comorbidityPoints();
      if (_profile.publicService) pts -= 2;
      if (_profile.elderPartner) pts -= 2;
      if (_profile.ig) pts += 5;
      if (_profile.likelypassed) pts += 2;
      if (_profile.others) pts += 1;
    }
    return pts;
  }

  double comorbidityPoints() {
    int pts = 0;
    if (_profile != null) {
      if (_profile.age > 80) pts += 3;
      if (_profile.age > 65 && _profile.age < 80) pts += 2;
      if (_profile.age > 50 && _profile.age < 65) pts += 1;
      if (_profile.heartDisease) pts += 2;
      if (_profile.hypertension) pts += 1;
      if (_profile.epoc) pts += 1;
      if (_profile.smoker) pts += 1;
      if (_profile.sex) pts += 1;
      if (_profile.fat) pts += 1;
      if (_profile.chemotherapy) pts += 3;
      if (_profile.inmunosuppressedhigh) pts += 2;
      if (_profile.inmunosuppressedlow) pts += 1;
      if (_profile.autoinmune) pts += 1;
      if (_profile.publicService) pts -= 2;
    }
    if (pts > 5) return -5;
    if (pts > 2 && pts < 6) return -5;
    if (pts < 3) return -1;
    return 0;
  }
}
