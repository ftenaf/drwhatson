import 'package:covid_buster_lite/ui/common/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void doLaunch(urlString) async {
      if (await canLaunch(urlString)) {
        launch(urlString);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text('about'), backgroundColor: Colors.blue),
        body: FutureBuilder(
            future: rootBundle.loadString("assets/about.md"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data,
                  onTapLink: (value) => doLaunch(value),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
        bottomNavigationBar: AppBottomNav());
  }
}
