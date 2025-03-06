// To parse this JSON data, do
//
//     final changePasswordRequest = changePasswordRequestFromJson(jsonString);

import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
  String? currentPassword;
  String? newPassword;
  String? newPasswordConfirmation;

  ChangePasswordRequest({
    this.currentPassword,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(
    currentPassword: json["current_password"],
    newPassword: json["new_password"],
    newPasswordConfirmation: json["new_password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "current_password": currentPassword,
    "new_password": newPassword,
    "new_password_confirmation": newPasswordConfirmation,
  };
}
