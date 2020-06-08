import 'package:flutter/foundation.dart';

class Profile {
  final int id;
  final String idString;
  int age;
  bool heartDisease;
  bool hypertension;
  bool epoc;
  bool smoker;
  bool sex;
  bool fat;
  bool chemotherapy;
  bool inmunosuppressedhigh;
  bool inmunosuppressedlow;
  bool autoinmune;
  bool others;

  bool likelypassed;
  bool publicService;
  bool elderPartner;
  bool ig;

  Profile(
      {@required this.id,
      @required this.idString,
      this.age,
      this.heartDisease,
      this.hypertension,
      this.epoc,
      this.smoker,
      this.sex,
      this.fat,
      this.chemotherapy,
      this.inmunosuppressedhigh,
      this.inmunosuppressedlow,
      this.autoinmune,
      this.likelypassed,
      this.publicService,
      this.elderPartner,
      this.ig,
      this.others});

  factory Profile.fromMap(Map<String, dynamic> data) {
    return Profile(
        id: data['id'] ?? '',
        idString: data['idString'] ?? 0,
        age: data['age'] ?? 0,
        heartDisease: data['heartDisease'] ?? false,
        hypertension: data['hypertension'] ?? false,
        epoc: data['epoc'] ?? false,
        smoker: data['smoker'] ?? false,
        sex: data['sex'] ?? false,
        fat: data['fat'] ?? false,
        chemotherapy: data['chemotherapy'] ?? false,
        inmunosuppressedhigh: data['inmunosuppressedhigh'] ?? false,
        inmunosuppressedlow: data['inmunosuppressedlow'] ?? false,
        autoinmune: data['autoinmune'] ?? false,
        likelypassed: data['likelypassed'] ?? false,
        publicService: data['publicService'] ?? false,
        elderPartner: data['elderPartner'] ?? false,
        ig: data['ig'] ?? false,
        others: data['others'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idString': idString,
      'age': age,
      'heartDisease': heartDisease,
      'hypertension': hypertension,
      'epoc': epoc,
      'smoker': smoker,
      'sex': sex,
      'fat': fat,
      'chemotherapy': chemotherapy,
      'inmunosuppressedhigh': inmunosuppressedhigh,
      'inmunosuppressedlow': inmunosuppressedlow,
      'autoinmune': autoinmune,
      'likelypassed': likelypassed,
      'publicService': publicService,
      'elderPartner': elderPartner,
      'ig': ig,
      'others': others
    };
  }
}
