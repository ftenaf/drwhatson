import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(title: Text('homePage.about'.tr()), backgroundColor: Colors.blue),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
          future: rootBundle.loadString("assets/data/about_${EasyLocalization.of(context).locale.toString()}.md"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  textAlign: WrapAlignment.spaceBetween,
                  unorderedListAlign: WrapAlignment.center,
                  orderedListAlign: WrapAlignment.center,
                  p: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                  h1: TextStyle(
                    color: Colors.deepOrange[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  a: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 25),
                  h1Align: WrapAlignment.center,
                  h2Align: WrapAlignment.center,
                  h6Align: WrapAlignment.center,
                ),
                onTapLink: (value) => doLaunch(value),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
