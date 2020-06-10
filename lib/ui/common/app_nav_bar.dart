import 'package:drwhatson/ui/views/about_screen.dart';
import 'package:drwhatson/ui/views/calendar_screen.dart';
import 'package:drwhatson/ui/views/home_screen.dart';
import 'package:drwhatson/ui/views/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

GlobalKey globalKey = new GlobalKey();

class AppNavBar extends StatefulWidget {
  @override
  _AppNavBarState createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _pageIndex = 0;
  final _pages = [
    TopicsScreen(),
    CalendarScreen(),
    AboutScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var colorIcon = Colors.black87;
    double sizeIcon = 40;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).appBarTheme.color,
          backgroundColor: Theme.of(context).backgroundColor,
          buttonBackgroundColor: Colors.blue[600],
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.elasticInOut,
          height: 50,
          index: _pageIndex,
          items: <Widget>[
            Icon(
              Icons.school,
              size: sizeIcon,
              color: colorIcon,
            ),
            Icon(
              Icons.calendar_today,
              size: sizeIcon,
              color: colorIcon,
            ),
            Icon(
              Icons.help,
              size: sizeIcon,
              color: colorIcon,
            ),
            Icon(
              Icons.account_circle,
              size: sizeIcon,
              color: colorIcon,
            )
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
