import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String division;
  final String idofficer;
  final String name;
  final String phone;
  final String position;
  final String status;
  final String surname;
  final String email;
  final String password;
  final String? token;
  UserModel({
    required this.division,
    required this.idofficer,
    required this.name,
    required this.phone,
    required this.position,
    required this.status,
    required this.surname,
    required this.email,
    required this.password,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'division': division,
      'idofficer': idofficer,
      'name': name,
      'phone': phone,
      'position': position,
      'status': status,
      'surname': surname,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      division: (map['division'] ?? '') as String,
      idofficer: (map['idofficer'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      position: (map['position'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      surname: (map['surname'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
