// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? uid;
  String? name;
  Timestamp? createdat;
  Timestamp? lastLoginAt;

  UserModel({
    this.email,
    this.uid,
    this.name,
    this.createdat,
    this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        uid: json["uid"],
        name: json["name"],
     
        createdat: json["createdat"],
        lastLoginAt: json["LastLoginAt"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "name": name,
        "createdat": createdat,
        "lastLoginAt": lastLoginAt,
    };
}
