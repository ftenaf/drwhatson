import 'package:covid_buster_lite/services/service_locator.dart';
import 'package:covid_buster_lite/ui/views/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Am I safe?',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TopicsScreen(),
        '/topics': (context) => TopicsScreen(),
      },
      // Theme
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black38,
        ),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
          bodyText2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline1: TextStyle(fontWeight: FontWeight.bold),
          subtitle1: TextStyle(color: Colors.grey),
        ),
        buttonTheme: ButtonThemeData(),
      ),
    );
  }
}
