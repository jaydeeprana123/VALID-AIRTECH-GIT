// To parse this JSON data, do
//
//     final resetPasswordResponse = resetPasswordResponseFromJson(jsonString);

import 'dart:convert';

ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) => json.encode(data.toJson());

class ResetPasswordResponse {
  int? status;
  String? message;
  Body? body;

  ResetPasswordResponse({
    this.status,
    this.message,
    this.body,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
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
  String? status;
  String? msg;
  int? f;

  Body({
    this.status,
    this.msg,
    this.f,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    status: json["status"],
    msg: json["msg"],
    f: json["f"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "f": f,
  };
}
