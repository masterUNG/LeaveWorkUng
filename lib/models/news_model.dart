// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String urlImage;
  final String title;
  final String detail;
  final Timestamp timestamp;
  NewsModel({
    required this.urlImage,
    required this.title,
    required this.detail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'title': title,
      'detail': detail,
      'timestamp': timestamp,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      urlImage: (map['urlImage'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
