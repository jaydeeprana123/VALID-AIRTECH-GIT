// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String? userName;
  String? passCode;

  LoginRequest({
    this.userName,
    this.passCode,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    userName: json["user_name"],
    passCode: json["pass_code"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "pass_code": passCode,
  };
}
