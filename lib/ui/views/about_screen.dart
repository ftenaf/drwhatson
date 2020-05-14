import 'package:covid_buster_lite/ui/common/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('about'), backgroundColor: Colors.blue),
        body: FutureBuilder(
            future: rootBundle.loadString("assets/about.md"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data);
              }
              return Center(child: CircularProgressIndicator());
            }),
        bottomNavigationBar: AppBottomNav());
  }
}
