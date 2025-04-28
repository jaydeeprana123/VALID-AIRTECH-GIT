// To parse this JSON data, do
//
//     final attendanceListResponse = attendanceListResponseFromJson(jsonString);

import 'dart:convert';

AttendanceListResponse attendanceListResponseFromJson(String str) => AttendanceListResponse.fromJson(json.decode(str));

String attendanceListResponseToJson(AttendanceListResponse data) => json.encode(data.toJson());

class AttendanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<AttendanceData>? data;

  AttendanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) => AttendanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AttendanceData>.from(json["data"]!.map((x) => AttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AttendanceData {
  int? id;
  int? empId;
  String? empName;
  String? date;
  String? time;
  int? typeLocation;
  String? typeLocationName;
  dynamic officeId;
  String? officeName;
  int? headId;
  String? headName;
  int? status;
  String? statusType;

  AttendanceData({
    this.id,
    this.empId,
    this.empName,
    this.date,
    this.time,
    this.typeLocation,
    this.typeLocationName,
    this.officeId,
    this.officeName,
    this.headId,
    this.headName,
    this.status,
    this.statusType,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
    id: json["id"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    date: json["date"],
    time: json["time"],
    typeLocation: json["type_location"],
    typeLocationName: json["type_location_name"],
    officeId: json["office_id"],
    officeName: json["office_name"],
    headId: json["head_id"],
    headName: json["head_name"],
    status: json["status"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "emp_name": empName,
    "date": date,
    "time": time,
    "type_location": typeLocation,
    "type_location_name": typeLocationName,
    "office_id": officeId,
    "office_name": officeName,
    "head_id": headId,
    "head_name": headName,
    "status": status,
    "status_type": statusType,
  };
}
