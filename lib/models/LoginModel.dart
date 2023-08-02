// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString?);

import 'dart:convert';

import 'package:hive/hive.dart';

part "LoginModel.g.dart";

LoginModel loginModelFromJson(String? str) =>
    LoginModel.fromJson(json.decode(str!));

class LoginModel {
  LoginData? data;

  LoginModel({
    this.data,
  });

  factory LoginModel.fromJson(Map<String?, dynamic> json) => LoginModel(
        data: LoginData.fromJson(json["data"]),
      );
}

@HiveType(typeId: 1)
class LoginData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  dynamic emailVerifiedAt;
  @HiveField(4)
  String? role;
  @HiveField(5)
  String? state;

  LoginData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.state,
  });

  factory LoginData.fromJson(Map<String?, dynamic> json) => LoginData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        state: json["state"],
      );
}
