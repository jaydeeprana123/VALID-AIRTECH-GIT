// To parse this JSON data, do
//
//     final adminCreateAttendanceRequest = adminCreateAttendanceRequestFromJson(jsonString);

import 'dart:convert';

AdminCreateAttendanceRequest adminCreateAttendanceRequestFromJson(String str) => AdminCreateAttendanceRequest.fromJson(json.decode(str));

String adminCreateAttendanceRequestToJson(AdminCreateAttendanceRequest data) => json.encode(data.toJson());

class AdminCreateAttendanceRequest {
  List<Attendence>? attendence;

  AdminCreateAttendanceRequest({
    this.attendence,
  });

  factory AdminCreateAttendanceRequest.fromJson(Map<String, dynamic> json) => AdminCreateAttendanceRequest(
    attendence: json["attendence"] == null ? [] : List<Attendence>.from(json["attendence"]!.map((x) => Attendence.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendence": attendence == null ? [] : List<dynamic>.from(attendence!.map((x) => x.toJson())),
  };
}

class Attendence {
  String? date;
  int? empId;
  int? attendenceStatus;
  List<OverTime>? overTime;

  Attendence({
    this.date,
    this.empId,
    this.attendenceStatus,
    this.overTime,
  });

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
    date: json["date"],
    empId: json["emp_id"],
    attendenceStatus: json["attendence_status"],
    overTime: json["over_time"] == null ? [] : List<OverTime>.from(json["over_time"]!.map((x) => OverTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "emp_id": empId,
    "attendence_status": attendenceStatus,
    "over_time": overTime == null ? [] : List<dynamic>.from(overTime!.map((x) => x.toJson())),
  };
}

class OverTime {
  int? overTimeStatus;

  OverTime({
    this.overTimeStatus,
  });

  factory OverTime.fromJson(Map<String, dynamic> json) => OverTime(
    overTimeStatus: json["over_time_status"],
  );

  Map<String, dynamic> toJson() => {
    "over_time_status": overTimeStatus,
  };
}
