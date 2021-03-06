import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

Widget getImage(String url, BuildContext context, BoxFit fit) {
  if (url == 'default.png') {
    return Icon(Icons.school, size: 150);
  } else if (url.startsWith('icon')) {
    /*int pos = url.indexOf(':') + 1;
    return Icon(IconData(int.parse(url.substring(pos)), fontFamily: 'MaterialIcons'), size: 150);*/
  } else if (url.startsWith('http')) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      fit: fit,
    );
  } else {
    return Image.asset(
      'assets/img/$url',
      fit: BoxFit.contain,
    );
  }
}
