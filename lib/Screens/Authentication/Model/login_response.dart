// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? status;
  String? message;
  LoginData? data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginData {
  String? eId;
  String? eEmployeeName;
  String? eWorkmanNo;
  String? eEmail;
  String? eMobile;
  String? eUserName;
  String? ePassword;
  String? eProfile;
  String? eEmployeeToken;
  String? eUserType;
  DateTime? eCreatedAt;

  LoginData({
    this.eId,
    this.eEmployeeName,
    this.eWorkmanNo,
    this.eEmail,
    this.eMobile,
    this.eUserName,
    this.ePassword,
    this.eProfile,
    this.eEmployeeToken,
    this.eUserType,
    this.eCreatedAt,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    eId: json["e_id"],
    eEmployeeName: json["e_employee_name"],
    eWorkmanNo: json["e_workman_no"],
    eEmail: json["e_email"],
    eMobile: json["e_mobile"],
    eUserName: json["e_user_name"],
    ePassword: json["e_password"],
    eProfile: json["e_profile"],
    eEmployeeToken: json["e_employee_token"],
    eUserType: json["e_user_type"],
    eCreatedAt: json["e_created_at"] == null ? null : DateTime.parse(json["e_created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "e_id": eId,
    "e_employee_name": eEmployeeName,
    "e_workman_no": eWorkmanNo,
    "e_email": eEmail,
    "e_mobile": eMobile,
    "e_user_name": eUserName,
    "e_password": ePassword,
    "e_profile": eProfile,
    "e_employee_token": eEmployeeToken,
    "e_user_type": eUserType,
    "e_created_at": eCreatedAt?.toIso8601String(),
  };
}
