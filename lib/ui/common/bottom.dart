import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.school, size: 20), title: Text('Topics')),
        BottomNavigationBarItem(
            icon: Icon(Icons.help, size: 20), title: Text('About')),
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
        }
      },
    );
  }
}
