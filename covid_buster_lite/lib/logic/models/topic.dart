import 'package:flutter/foundation.dart';

class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final String version;

  Topic(
      {@required this.id,
      this.title,
      this.description,
      this.img,
      this.version});

  factory Topic.fromMap(Map<String, dynamic> data) {
    return Topic(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        img: data['img'] ?? 'default.png');
  }
}
