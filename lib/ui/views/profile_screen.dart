import 'package:drwhatson/logic/models/profile.dart';
import 'package:drwhatson/logic/view_models/profile_vm.dart';
import 'package:drwhatson/services/common/language_helper.dart';
import 'package:drwhatson/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel model = serviceLocator<ProfileViewModel>();
  Future<Profile> _profile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  String ageError;

  @override
  void initState() {
    _profile = model.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("homePage.appBarTitle".tr())),
      body: FutureBuilder<Profile>(
          future: _profile,
          builder: (context, snap) {
            if (snap.hasError) return Text("Error: ${snap.error}");
            if (snap.hasData) {
              var profileData = snap.data;
              _ageController.text =
                  profileData.age > 0 ? profileData.age.toString() : "";
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'profile.points',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ).tr(namedArgs: {'points': model.points.toString()}),
                        Divider(),
                        Text(
                          (model.comorbidityPoints() == -5
                              ? "profile.veryHighRisk".tr()
                              : (model.comorbidityPoints() == -2.5)
                                  ? "profile.highRisk".tr()
                                  : "profile.moderatedRisk".tr()),
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton(
                          child: Text("homePage.selectLanguage".tr()),
                          onPressed: () => _showSelectLanguageDialog(),
                          color: Colors.blueAccent,
                        ),
                        Divider(),
                        Expanded(
                          child: editForm(profileData),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: const CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation(Colors.red))),
              );
            }
          }),
    );
  }

  Widget editForm(Profile profile) {
    return Form(
        key: _formKey,
        child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'profile.age'.tr(),
                        hintText: 'profile.age'.tr(),
                      ),
                      onFieldSubmitted: (value) async {
                        setState(() {
                          profile.age = int.parse(value);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required.';
                        }
                        if (ageError != null) {
                          return ageError;
                        }
                        return null;
                      },
                    ),
                    Row(children: [
                      Checkbox(
                        value: profile.autoinmune,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.autoinmune = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.autoinmune'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.others,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.others = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.others'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.inmunosuppressedhigh,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.inmunosuppressedhigh = value;
                          });
                        },
                      ),
                      Expanded(
                          child: Text('profile.inmunosuppressedhigh'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.inmunosuppressedlow,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.inmunosuppressedlow = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.inmunosuppressedlow'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.chemotherapy,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.chemotherapy = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.chemotherapy'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.fat,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.fat = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.fat'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.sex,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.sex = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.sex'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.smoker,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.smoker = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.smoker'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.epoc,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.epoc = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.epoc'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.hypertension,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.hypertension = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.hypertension'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.heartDisease,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.heartDisease = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.heartDisease'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.publicService,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.publicService = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.publicService'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.elderPartner,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.elderPartner = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.elderPartner'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.ig,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.ig = value;
                          });
                        },
                      ),
                      Expanded(child: Text('profile.ig'.tr())),
                    ]),
                    Row(children: [
                      Checkbox(
                        value: profile.likelypassed,
                        onChanged: (bool value) async {
                          setState(() {
                            profile.likelypassed = value;
                          });
                        },
                      ),
                      Expanded(
                          child: Text(
                        'profile.likelypassed'.tr(),
                        textAlign: TextAlign.justify,
                      )),
                    ]),
                    Divider(),
                    RaisedButton(
                      child: Text(
                        'profile.save'.tr(),
                        style: TextStyle(fontSize: 30),
                      ),
                      color: Colors.green,
                      onPressed: () async {
                        setState(() {
                          ageError = null;
                        });

                        if (_formKey.currentState.validate()) {
                          try {
                            profile.age = int.parse(_ageController.text);
                            model.saveProfile(profile);
                            _showSavedConfirmation();
                          } catch (e) {
                            print(e.code);
                          }
                        }
                      },
                    ),
                  ],
                )))));
  }

  void _showSavedConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('profile.saved'.tr()),
          actions: <Widget>[
            Text(
              'profile.points',
              textAlign: TextAlign.center,
            ).tr(namedArgs: {'points': model.points.toString()}),
            Divider(height: 1),
            FlatButton(
              child: Text('profile.continue'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSelectLanguageDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("homePage.dialogTitleSelectLanguage".tr()),
            children: <Widget>[
              RadioListTile(
                  title: Text("homePage.spanish".tr()),
                  value: LanguageHelper.kSpanishLocale,
                  groupValue: 0,
                  onChanged: (_) {
                    EasyLocalization.of(context).locale =
                        LanguageHelper.kSpanishLocale;
                    Navigator.pop(context);
                  }),
              Divider(height: 1),
              RadioListTile(
                  title: Text("homePage.english".tr()),
                  value: LanguageHelper.kEnglishLocale,
                  groupValue: 0,
                  onChanged: (_) {
                    EasyLocalization.of(context).locale =
                        LanguageHelper.kEnglishLocale;
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }
}
