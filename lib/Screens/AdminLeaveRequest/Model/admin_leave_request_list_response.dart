// To parse this JSON data, do
//
//     final adminLeaveRequestListResponse = adminLeaveRequestListResponseFromJson(jsonString);

import 'dart:convert';

AdminLeaveRequestListResponse adminLeaveRequestListResponseFromJson(String str) => AdminLeaveRequestListResponse.fromJson(json.decode(str));

String adminLeaveRequestListResponseToJson(AdminLeaveRequestListResponse data) => json.encode(data.toJson());

class AdminLeaveRequestListResponse {
  bool? status;
  String? message;
  int? code;
  List<AdminLeaveRequestData>? data;

  AdminLeaveRequestListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AdminLeaveRequestListResponse.fromJson(Map<String, dynamic> json) => AdminLeaveRequestListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AdminLeaveRequestData>.from(json["data"]!.map((x) => AdminLeaveRequestData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AdminLeaveRequestData {
  int? id;
  String? leaveRequestDate;
  int? empId;
  String? employeeName;
  int? leaveRequestType;
  String? leaveRequestTypeName;
  String? fromDate;
  dynamic toDate;
  String? numberOfLeaveDays;
  String? reason;
  int? status;
  String? statusType;

  AdminLeaveRequestData({
    this.id,
    this.leaveRequestDate,
    this.empId,
    this.employeeName,
    this.leaveRequestType,
    this.leaveRequestTypeName,
    this.fromDate,
    this.toDate,
    this.numberOfLeaveDays,
    this.reason,
    this.status,
    this.statusType,
  });

  factory AdminLeaveRequestData.fromJson(Map<String, dynamic> json) => AdminLeaveRequestData(
    id: json["id"],
    leaveRequestDate: json["leave_request_date"],
    empId: json["emp_id"],
    employeeName: json["employee_name"],
    leaveRequestType: json["leave_request_type"],
    leaveRequestTypeName: json["leave_request_type_name"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    numberOfLeaveDays: json["number_of_leave_days"],
    reason: json["reason"],
    status: json["status"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_request_date": leaveRequestDate,
    "emp_id": empId,
    "employee_name": employeeName,
    "leave_request_type": leaveRequestType,
    "leave_request_type_name": leaveRequestTypeName,
    "from_date": fromDate,
    "to_date": toDate,
    "number_of_leave_days": numberOfLeaveDays,
    "reason": reason,
    "status": status,
    "status_type": statusType,
  };
}
