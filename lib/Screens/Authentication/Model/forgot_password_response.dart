// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) => ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) => json.encode(data.toJson());

class ForgotPasswordResponse {
  int? status;
  String? message;
  Body? body;

  ForgotPasswordResponse({
    this.status,
    this.message,
    this.body,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
    status: json["status"],
    message: json["message"],
    body: json["body"] == null ? null : Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": body?.toJson(),
  };
}

class Body {
  String? id;
  String? mail;
  String? status;
  String? msg;
  int? f;

  Body({
    this.id,
    this.mail,
    this.status,
    this.msg,
    this.f,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    id: json["id"],
    mail: json["mail"],
    status: json["status"],
    msg: json["msg"],
    f: json["f"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mail": mail,
    "status": status,
    "msg": msg,
    "f": f,
  };
}
