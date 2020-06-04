import 'package:covid_buster_lite/ui/views/about_screen.dart';
import 'package:covid_buster_lite/ui/views/home_screen.dart';
import 'package:covid_buster_lite/ui/views/profile_screen.dart';
import 'package:covid_buster_lite/ui/views/quiz_screen.dart';
import 'package:covid_buster_lite/ui/views/topic_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

GlobalKey globalKey = new GlobalKey();

class HomeNavBar extends StatefulWidget {
  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int _pageIndex = 0;
  final _pages = [TopicsScreen(), AboutScreen(), ProfileScreen(), TopicScreen(), QuizScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue[700],
          backgroundColor: Colors.grey[400],
          buttonBackgroundColor: Colors.blue[700],
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.fastLinearToSlowEaseIn,
          height: 50,
          index: _pageIndex,
          items: <Widget>[
            Icon(Icons.school, size: 40),
            Icon(Icons.help, size: 40),
            Icon(Icons.account_circle, size: 40)
          ],
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          key: globalKey,
        ),
        body: Container(
          child: _pages[_pageIndex],
        ));
  }
}
