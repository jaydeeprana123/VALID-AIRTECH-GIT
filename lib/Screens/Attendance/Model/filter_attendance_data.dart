// To parse this JSON data, do
//
//     final attendanceListResponse = attendanceListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:valid_airtech/Screens/Attendance/Model/site_attendance_data.dart';

class FilterAttendanceData{

  String? date;

  List<SiteAttendanceData> siteAttendanceData = <SiteAttendanceData>[];

  String? officeDuration;
  String? siteDuration;
}
