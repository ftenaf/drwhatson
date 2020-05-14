import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

Widget getImage(String url, BuildContext context, BoxFit fit) {
  if (url == 'default.png') {
    return Icon(
      Icons.school,
      size: 150,
    );
  } else if (!url.startsWith('http')) {
    return Image.asset(
      'assets/$url',
      fit: BoxFit.contain,
    );
  } else {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      fit: fit,
    );
  }
}
