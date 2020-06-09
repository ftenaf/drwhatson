import 'package:covid_buster_lite/ui/common/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _goHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AppNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.red])),
        ),
        Center(
            child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Covid Buster',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white, shadows: <Shadow>[
              Shadow(blurRadius: 18.0, color: Colors.black87, offset: Offset.fromDirection(120, 12))
            ]),
          ),
        )),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    _goHome();
  }
}
