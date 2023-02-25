// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveWorkModel {
  final String approve;
  final String leave;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp recordDate;
  LeaveWorkModel({
    required this.approve,
    required this.leave,
    required this.startDate,
    required this.endDate,
    required this.recordDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'approve': approve,
      'leave': leave,
      'startDate': startDate,
      'endDate': endDate,
      'recordDate': recordDate,
    };
  }

  factory LeaveWorkModel.fromMap(Map<String, dynamic> map) {
    return LeaveWorkModel(
      approve: (map['approve'] ?? '') as String,
      leave: (map['leave'] ?? '') as String,
      startDate: (map['startDate']),
      endDate: (map['endDate']),
      recordDate: (map['recordDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveWorkModel.fromJson(String source) =>
      LeaveWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
