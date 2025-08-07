import 'dart:convert';
import 'package:valid_airtech/Screens/Attendance/Model/site_attendance_data.dart';

class FilterAttendanceData {
  String? date;
  List<SiteAttendanceData> siteAttendanceData;
  String? officeDuration;
  String? siteDuration;
  String? overallSiteInTime;
  String? overallSiteOutTime;
  String? overallOfficeInTime;
  String? overallOfficeOutTime;
  String? attendanceStatus;
  String? lat;
  String? long;
  String? address;

  FilterAttendanceData({
    this.date,
    this.siteAttendanceData = const [],
    this.officeDuration,
    this.siteDuration,
    this.overallSiteInTime,
    this.overallSiteOutTime,
    this.overallOfficeInTime,
    this.overallOfficeOutTime,
    this.attendanceStatus,
    this.lat,
    this.long,
    this.address
  });

  factory FilterAttendanceData.fromJson(Map<String, dynamic> json) {
    return FilterAttendanceData(
      date: json['date'],
      siteAttendanceData: json['siteAttendanceData'] != null
          ? List<SiteAttendanceData>.from(
          json['siteAttendanceData'].map((x) => SiteAttendanceData.fromJson(x)))
          : [],
      officeDuration: json['officeDuration'],
      siteDuration: json['siteDuration'],
      overallSiteInTime: json['overallSiteInTime'],
      overallSiteOutTime: json['overallSiteOutTime'],
      overallOfficeInTime: json['overallOfficeInTime'],
      overallOfficeOutTime: json['overallOfficeOutTime'],
      attendanceStatus: json['attendanceStatus'],
      lat: json['lat'],
      long: json['long'],
        address:json["address"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'siteAttendanceData': siteAttendanceData.map((x) => x.toJson()).toList(),
      'officeDuration': officeDuration,
      'siteDuration': siteDuration,
      'overallSiteInTime': overallSiteInTime,
      'overallSiteOutTime': overallSiteOutTime,
      'overallOfficeInTime': overallOfficeInTime,
      'overallOfficeOutTime': overallOfficeOutTime,
      'attendanceStatus': attendanceStatus,
      'lat': lat,
      "long":long
    };
  }
}
