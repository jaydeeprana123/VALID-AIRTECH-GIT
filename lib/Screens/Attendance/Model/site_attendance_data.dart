// To parse this JSON data, do
//
//     final attendanceListResponse = attendanceListResponseFromJson(jsonString);

import 'dart:convert';


class SiteAttendanceData {
  String? dateOfAttendance;
  int? headId;
  int? officeId;
  String? siteName;
  String? inTime;
  String? outTime;
  bool isWorkReportAvail = false;


  SiteAttendanceData({
    this.dateOfAttendance,
    this.headId,
    this.officeId,
    this.siteName,
    this.inTime,
    this.outTime,
  });

  // From JSON
  factory SiteAttendanceData.fromJson(Map<String, dynamic> json) {
    return SiteAttendanceData(
      headId: json['headId'],
      officeId: json['officeId'],
      siteName: json['siteName'],
      inTime: json['inTime'],
      outTime: json['outTime'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'headId': headId,
      'officeId': officeId,
      'siteName': siteName,
      'inTime': inTime,
      'outTime': outTime,
    };
  }
}
