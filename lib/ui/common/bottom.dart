import 'package:covid_buster_lite/ui/views/about_screen.dart';
import 'package:covid_buster_lite/ui/views/home_screen.dart';
import 'package:covid_buster_lite/ui/views/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  final TopicsScreen topicsScreen = new TopicsScreen();
  final AboutScreen aboutScreen = new AboutScreen();
  final ProfileScreen profileScreen = new ProfileScreen();

  Widget _showPage = new TopicsScreen();
  Widget _pageChooser(int index) {
    switch (index) {
      case 0:
        return topicsScreen;
      case 1:
        return aboutScreen;
      case 2:
        return profileScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.grey,
          backgroundColor: Colors.deepPurple[400],
          buttonBackgroundColor: Colors.deepPurple[200],
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          height: 50,
          index: pageIndex,
          items: <Widget>[
            Icon(Icons.school, size: 20),
            Icon(Icons.help, size: 20),
            Icon(Icons.account_circle, size: 20)
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
              //_pageChooser(index);
            });
          },
        ),
        body: Container(
          child: _pageChooser(pageIndex),
        ));
  }
}
/*
class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.grey,
      backgroundColor: Colors.deepPurple[400],
      buttonBackgroundColor: Colors.deepPurple[200],
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.bounceInOut,
      height: 50,
      items: <Widget>[Icon(Icons.school, size: 20), Icon(Icons.help, size: 20), Icon(Icons.account_circle, size: 20)],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/about');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
    );
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.school, size: 20), title: Text('homePage.topics'.tr())),
        BottomNavigationBarItem(icon: Icon(Icons.help, size: 20), title: Text('homePage.about'.tr())),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 20), title: Text('homePage.profile'.tr())),
      ].toList(),
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
    */
