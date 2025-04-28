// To parse this JSON data, do
//
//     final createAttendanceInRequest = createAttendanceInRequestFromJson(jsonString);

import 'dart:convert';

CreateAttendanceInRequest createAttendanceInRequestFromJson(String str) => CreateAttendanceInRequest.fromJson(json.decode(str));

String createAttendanceInRequestToJson(CreateAttendanceInRequest data) => json.encode(data.toJson());

class CreateAttendanceInRequest {
  String? empId;
  String? date;
  String? time;
  String? typeLocation;
  String? officeId;
  String? headId;
  String? status;

  CreateAttendanceInRequest({
    this.empId,
    this.date,
    this.time,
    this.typeLocation,
    this.officeId,
    this.headId,
    this.status,
  });

  factory CreateAttendanceInRequest.fromJson(Map<String, dynamic> json) => CreateAttendanceInRequest(
    empId: json["emp_id"],
    date: json["date"],
    time: json["time"],
    typeLocation: json["type_location"],
    officeId: json["office_id"],
    headId: json["head_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "date": date,
    "time": time,
    "type_location": typeLocation,
    "office_id": officeId,
    "head_id": headId,
    "status": status,
  };
}
