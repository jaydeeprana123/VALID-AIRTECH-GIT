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
  String? siteInLat;
  String? siteInLong;
  String? siteOutLat;
  String? siteOutLong;
  String? siteInAddress;
  String? siteOutAddress;

  SiteAttendanceData({
    this.dateOfAttendance,
    this.headId,
    this.officeId,
    this.siteName,
    this.inTime,
    this.outTime,
    this.workReportData,
    this.siteInLat,
    this.siteInLong,
    this.siteOutLat,
    this.siteOutLong,
    this.siteInAddress,
    this.siteOutAddress,
  });

  // From JSON
  factory SiteAttendanceData.fromJson(Map<String, dynamic> json) {
    return SiteAttendanceData(
      headId: json['headId'],
      officeId: json['officeId'],
      siteName: json['siteName'],
      inTime: json['inTime'],
      outTime: json['outTime'],
      siteInLat: json['siteInLat'],
      siteInLong: json['siteInLong'],
      siteOutLat: json['siteOutLat'],
      siteOutLong: json['siteOutLong'],
      siteInAddress: json["siteInAddress"],
      siteOutAddress: json["siteOutAddress"],
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
      'siteInLat': siteInLat,
      'siteInLong': siteInLong,
      'siteOutLat': siteOutLat,
      'siteOutLong': siteOutLong,
      "siteInAddress": siteInAddress,
      "siteOutAddress": siteOutAddress
    };
  }
}
