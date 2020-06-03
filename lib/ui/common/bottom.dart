import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
