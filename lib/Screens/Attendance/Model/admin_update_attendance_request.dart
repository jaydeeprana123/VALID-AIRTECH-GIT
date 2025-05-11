// To parse this JSON data, do
//
//     final adminUpdateAttendanceRequest = adminUpdateAttendanceRequestFromJson(jsonString);

import 'dart:convert';

AdminUpdateAttendanceRequest adminUpdateAttendanceRequestFromJson(String str) => AdminUpdateAttendanceRequest.fromJson(json.decode(str));

String adminUpdateAttendanceRequestToJson(AdminUpdateAttendanceRequest data) => json.encode(data.toJson());

class AdminUpdateAttendanceRequest {
  int? id;
  int? attendenceStatus;
  List<UpdateOverTime>? overTime;

  AdminUpdateAttendanceRequest({
    this.id,
    this.attendenceStatus,
    this.overTime,
  });

  factory AdminUpdateAttendanceRequest.fromJson(Map<String, dynamic> json) => AdminUpdateAttendanceRequest(
    id: json["id"],
    attendenceStatus: json["attendence_status"],
    overTime: json["over_time"] == null ? [] : List<UpdateOverTime>.from(json["over_time"]!.map((x) => UpdateOverTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_status": attendenceStatus,
    "over_time": overTime == null ? [] : List<dynamic>.from(overTime!.map((x) => x.toJson())),
  };
}

class UpdateOverTime {
  int? id;
  int? overTimeStatus;

  UpdateOverTime({
    this.id,
    this.overTimeStatus,
  });

  factory UpdateOverTime.fromJson(Map<String, dynamic> json) => UpdateOverTime(
    id: json["id"],
    overTimeStatus: json["over_time_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "over_time_status": overTimeStatus,
  };
}
