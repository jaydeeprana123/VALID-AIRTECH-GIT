// To parse this JSON data, do
//
//     final employeeListResponse = employeeListResponseFromJson(jsonString);

import 'dart:convert';

EmployeeListResponse employeeListResponseFromJson(String str) => EmployeeListResponse.fromJson(json.decode(str));

String employeeListResponseToJson(EmployeeListResponse data) => json.encode(data.toJson());

class EmployeeListResponse {
  int? status;
  List<EmployeeData>? data;

  EmployeeListResponse({
    this.status,
    this.data,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) => EmployeeListResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<EmployeeData>.from(json["data"]!.map((x) => EmployeeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EmployeeData {
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
  dynamic wpDepartmentAddress;
  dynamic wpResidentAddress;
  String? utUserTypeName;
  String? isResigned;

  EmployeeData({
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
    this.wpDepartmentAddress,
    this.wpResidentAddress,
    this.utUserTypeName,
    this.isResigned,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
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
    wpDepartmentAddress: json["wp_department_address"],
    wpResidentAddress: json["wp_resident_address"],
    utUserTypeName: json["ut_user_type_name"],
    isResigned: json["is_resigned"],
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
    "wp_department_address": wpDepartmentAddress,
    "wp_resident_address": wpResidentAddress,
    "ut_user_type_name": utUserTypeName,
    "is_resigned": isResigned,
  };
}
