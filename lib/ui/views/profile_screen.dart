import 'package:covid_buster_lite/services/common/language_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homePage.appBarTitle".tr()),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("homePage.hello".tr()),
          RaisedButton(
            child: Text("homePage.selectLanguage".tr()),
            onPressed: () => _showSelectLanguageDialog(),
          )
        ],
      )),
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
                    EasyLocalization.of(context).locale = LanguageHelper.kSpanishLocale;
                    Navigator.pop(context);
                  }),
              Divider(height: 1),
              RadioListTile(
                  title: Text("homePage.english".tr()),
                  value: LanguageHelper.kEnglishLocale,
                  groupValue: 0,
                  onChanged: (_) {
                    EasyLocalization.of(context).locale = LanguageHelper.kEnglishLocale;
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
