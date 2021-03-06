import 'package:drwhatson/services/common/language_helper.dart';
import 'package:drwhatson/services/service_locator.dart';
import 'package:drwhatson/ui/views/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  setupServiceLocator();
  runApp(EasyLocalization(
    supportedLocales: [
      LanguageHelper.kSpanishLocale,
      LanguageHelper.kEnglishLocale,
    ],
    fallbackLocale: Locale('es', 'ES'),
    startLocale: Locale('es', 'ES'),
    saveLocale: true,
    path: 'assets/languages',
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'homePage.appBarTitle'.tr(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), //AppNavBar(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black38,
        ),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(color: Colors.blue),
        textTheme: TextTheme(
          headline1:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 18),
          bodyText2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: Colors.black38, fontSize: 15),
          subtitle1: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
