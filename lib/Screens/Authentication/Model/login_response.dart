// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? status;
  String? message;
  int? code;
  List<LoginData>? data;
  String? token;

  LoginResponse({
    this.status,
    this.message,
    this.code,
    this.data,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<LoginData>.from(json["data"]!.map((x) => LoginData.fromJson(x))),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "token": token,
  };
}

class LoginData {
  int? id;
  String? name;
  String? userName;
  String? passCode;
  String? email;
  String? mobileNumber;
  int? roleId;
  String? status;
  dynamic photo;
  String? token;

  LoginData({
    this.id,
    this.name,
    this.userName,
    this.passCode,
    this.email,
    this.mobileNumber,
    this.roleId,
    this.status,
    this.photo,
    this.token
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"],
    name: json["name"],
    userName: json["user_name"],
    passCode: json["pass_code"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    roleId: json["role_id"],
    status: json["status"],
    photo: json["photo"],
    token:json["token"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_name": userName,
    "pass_code": passCode,
    "email": email,
    "mobile_number": mobileNumber,
    "role_id": roleId,
    "status": status,
    "photo": photo,
    "token":token
  };
}
