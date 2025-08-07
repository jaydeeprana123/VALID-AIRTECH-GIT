// To parse this JSON data, do
//
//     final attendanceListResponse = attendanceListResponseFromJson(jsonString);

import 'dart:convert';

import '../../WorkReport/Model/work_report_list_response.dart';


class SiteAttendanceData {
  String? dateOfAttendance;
  int? headId;
  int? officeId;
  String? siteName;
  String? inTime;
  String? outTime;
  bool isWorkReportAvail = false;
  WorkReportData? workReportData;
  String? lat;
  String? long;


  SiteAttendanceData({
    this.dateOfAttendance,
    this.headId,
    this.officeId,
    this.siteName,
    this.inTime,
    this.outTime,
    this.workReportData,
    this.lat,
    this.long
  });

  // From JSON
  factory SiteAttendanceData.fromJson(Map<String, dynamic> json) {
    return SiteAttendanceData(
      headId: json['headId'],
      officeId: json['officeId'],
      siteName: json['siteName'],
      inTime: json['inTime'],
      outTime: json['outTime'],
      lat: json['lat'],
      long: json['long'],
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
      'lat': lat,
      'long': long,
    };
  }
}
