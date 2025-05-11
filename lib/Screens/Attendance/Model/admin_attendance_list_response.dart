// To parse this JSON data, do
//
//     final adminAttendanceListResponse = adminAttendanceListResponseFromJson(jsonString);

import 'dart:convert';

AdminAttendanceListResponse adminAttendanceListResponseFromJson(String str) => AdminAttendanceListResponse.fromJson(json.decode(str));

String adminAttendanceListResponseToJson(AdminAttendanceListResponse data) => json.encode(data.toJson());

class AdminAttendanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<AdminAttendanceData>? data;

  AdminAttendanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AdminAttendanceListResponse.fromJson(Map<String, dynamic> json) => AdminAttendanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AdminAttendanceData>.from(json["data"]!.map((x) => AdminAttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AdminAttendanceData {
  int? id;
  int? empId;
  String? empName;
  String? date;
  int? attendenceStatus;
  String? attendenceStatusName;
  List<OverTime>? overTime;

  bool isCheckedES = false;
  bool isCheckedPO = false;
  bool isCheckedPH = false;

  int? idES;
  int? idPO;
  int? iddPH;



  AdminAttendanceData({
    this.id,
    this.empId,
    this.empName,
    this.date,
    this.attendenceStatus,
    this.attendenceStatusName,
    this.overTime,
  });

  factory AdminAttendanceData.fromJson(Map<String, dynamic> json) => AdminAttendanceData(
    id: json["id"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    date: json["date"],
    attendenceStatus: json["attendence_status"],
    attendenceStatusName: json["attendence_status_name"],
    overTime: json["over_time"] == null ? [] : List<OverTime>.from(json["over_time"]!.map((x) => OverTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "emp_name": empName,
    "date": date,
    "attendence_status": attendenceStatus,
    "attendence_status_name": attendenceStatusName,
    "over_time": overTime == null ? [] : List<dynamic>.from(overTime!.map((x) => x.toJson())),
  };
}

class OverTime {
  int? id;
  int? empId;
  int? employeeAttendenceId;
  String? overTimeStatus;
  String? overTimeName;

  OverTime({
    this.id,
    this.empId,
    this.employeeAttendenceId,
    this.overTimeStatus,
    this.overTimeName,
  });

  factory OverTime.fromJson(Map<String, dynamic> json) => OverTime(
    id: json["id"],
    empId: json["emp_id"],
    employeeAttendenceId: json["employee_attendence_id"],
    overTimeStatus: json["over_time_status"],
    overTimeName: json["over_time_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "employee_attendence_id": employeeAttendenceId,
    "over_time_status": overTimeStatus,
    "over_time_name": overTimeName,
  };
}
