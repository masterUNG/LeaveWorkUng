import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LeaveModel {
  final String leave;
  LeaveModel({
    required this.leave,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'leave': leave,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      leave: (map['leave'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveModel.fromJson(String source) => LeaveModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
