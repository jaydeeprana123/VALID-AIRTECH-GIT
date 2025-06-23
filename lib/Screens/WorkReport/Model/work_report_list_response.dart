// To parse this JSON data, do
//
//     final workReportListResponse = workReportListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

WorkReportListResponse workReportListResponseFromJson(String str) => WorkReportListResponse.fromJson(json.decode(str));

String workReportListResponseToJson(WorkReportListResponse data) => json.encode(data.toJson());

class WorkReportListResponse {
  bool? status;
  String? message;
  int? code;
  List<WorkReportData>? data;

  WorkReportListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory WorkReportListResponse.fromJson(Map<String, dynamic> json) => WorkReportListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<WorkReportData>.from(json["data"]!.map((x) => WorkReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WorkReportData {
  int? id;
  dynamic attendenceId;
  int? siteId;
  String? date;
  String? contactName;
  dynamic train;
  dynamic bus;
  dynamic auto;
  dynamic fuel;
  dynamic foodAmount;
  dynamic other;
  dynamic remarkForOther;
  int? convenyenceThroughStatus;
  String? convenyenceThroughName;
  String? convenyenceThroughOther;
  String? conveyanceId;
  String? conveyanceName;
  String? serviceNatureId;
  String? serviceNatureName;
  String? contactPerson;
  String? witnessPerson;
  List<RemarkWorkReport>? remark;
  List<dynamic>? workReportExpensesBill;
  List<SiteAttendBy>? siteAttendBy;
  List<ServiceStatus>? serviceStatus;

  WorkReportData({
    this.id,
    this.attendenceId,
    this.siteId,
    this.date,
    this.contactName,
    this.train,
    this.bus,
    this.auto,
    this.fuel,
    this.foodAmount,
    this.other,
    this.remarkForOther,
    this.convenyenceThroughStatus,
    this.convenyenceThroughName,
    this.convenyenceThroughOther,
    this.conveyanceId,
    this.conveyanceName,
    this.serviceNatureId,
    this.serviceNatureName,
    this.contactPerson,
    this.witnessPerson,
    this.remark,
    this.workReportExpensesBill,
    this.siteAttendBy,
    this.serviceStatus,
  });

  factory WorkReportData.fromJson(Map<String, dynamic> json) => WorkReportData(
    id: json["id"],
    attendenceId: json["attendence_id"],
    siteId: json["site_id"],
    date: json["date"],
    contactName: json["contact_name"],
    train: json["train"],
    bus: json["bus"],
    auto: json["auto"],
    fuel: json["fuel"],
    foodAmount: json["food_amount"],
    other: json["other"],
    remarkForOther: json["remark_for_other"],
    convenyenceThroughStatus: json["convenyence_through_status"],
    convenyenceThroughName: json["convenyence_through_name"],
    convenyenceThroughOther: json["convenyence_through_other"],
    conveyanceId: json["conveyance_id"],
    conveyanceName: json["conveyance_name"],
    serviceNatureId: json["service_nature_id"],
    serviceNatureName: json["service_nature_name"],
    contactPerson: json["contact_person"],
    witnessPerson: json["witness_person"],
    remark: json["remark"] == null ? [] : List<RemarkWorkReport>.from(json["remark"]!.map((x) => RemarkWorkReport.fromJson(x))),
    workReportExpensesBill: json["workReportExpensesBill"] == null ? [] : List<dynamic>.from(json["workReportExpensesBill"]!.map((x) => x)),
    siteAttendBy: json["siteAttendBy"] == null ? [] : List<SiteAttendBy>.from(json["siteAttendBy"]!.map((x) => SiteAttendBy.fromJson(x))),
    serviceStatus: json["serviceStatus"] == null ? [] : List<ServiceStatus>.from(json["serviceStatus"]!.map((x) => ServiceStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "site_id": siteId,
    "date": date,
    "contact_name": contactName,
    "train": train,
    "bus": bus,
    "auto": auto,
    "fuel": fuel,
    "food_amount": foodAmount,
    "other": other,
    "remark_for_other": remarkForOther,
    "convenyence_through_status": convenyenceThroughStatus,
    "convenyence_through_name": convenyenceThroughName,
    "convenyence_through_other": convenyenceThroughOther,
    "conveyance_id": conveyanceId,
    "conveyance_name": conveyanceName,
    "service_nature_id": serviceNatureId,
    "service_nature_name": serviceNatureName,
    "contact_person": contactPerson,
    "witness_person": witnessPerson,
    "remark": remark == null ? [] : List<dynamic>.from(remark!.map((x) => x.toJson())),
    "workReportExpensesBill": workReportExpensesBill == null ? [] : List<dynamic>.from(workReportExpensesBill!.map((x) => x)),
    "siteAttendBy": siteAttendBy == null ? [] : List<dynamic>.from(siteAttendBy!.map((x) => x.toJson())),
    "serviceStatus": serviceStatus == null ? [] : List<dynamic>.from(serviceStatus!.map((x) => x.toJson())),
  };
}

class RemarkWorkReport {
  int? id;
  dynamic attendenceId;
  int? workReportId;
  String? remark;
  TextEditingController remarkTextEditingController = TextEditingController();

  RemarkWorkReport({
    this.id,
    this.attendenceId,
    this.workReportId,
    this.remark,
  });

  factory RemarkWorkReport.fromJson(Map<String, dynamic> json) => RemarkWorkReport(
    id: json["id"],
    attendenceId: json["attendence_id"],
    workReportId: json["work_report_id"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "work_report_id": workReportId,
    "remark": remark,
  };
}

class ServiceStatus {
  int? id;
  dynamic attendenceId;
  int? workReportId;
  String? testLocation;
  String? roomEquipment;
  int? testPerfomedId;
  String? testPerfomedName;
  int? status;
  String? statusType;
  int? headInstrumentId;
  dynamic headInstrumentName;
  int? performUserId;
  String? remark;


  ServiceStatus({
    this.id,
    this.attendenceId,
    this.workReportId,
    this.testLocation,
    this.roomEquipment,
    this.testPerfomedId,
    this.testPerfomedName,
    this.status,
    this.statusType,
    this.headInstrumentId,
    this.headInstrumentName,
    this.performUserId,
    this.remark,
  });

  factory ServiceStatus.fromJson(Map<String, dynamic> json) => ServiceStatus(
    id: json["id"],
    attendenceId: json["attendence_id"],
    workReportId: json["work_report_id"],
    testLocation: json["test_location"],
    roomEquipment: json["room_equipment"],
    testPerfomedId: json["test_perfomed_id"],
    testPerfomedName: json["test_perfomed_name"],
    status: json["status"],
    statusType: json["status_type"],
    headInstrumentId: json["head_instrument_id"],
    headInstrumentName: json["head_instrument_name"],
    performUserId: json["perform_user_id"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "work_report_id": workReportId,
    "test_location": testLocation,
    "room_equipment": roomEquipment,
    "test_perfomed_id": testPerfomedId,
    "test_perfomed_name": testPerfomedName,
    "status": status,
    "status_type": statusType,
    "head_instrument_id": headInstrumentId,
    "head_instrument_name": headInstrumentName,
    "perform_user_id": performUserId,
    "remark": remark,
  };
}

class SiteAttendBy {
  int? id;
  dynamic attendenceId;
  int? workReportId;
  int? userId;
  String? userName;

  SiteAttendBy({
    this.id,
    this.attendenceId,
    this.workReportId,
    this.userId,
    this.userName,
  });

  factory SiteAttendBy.fromJson(Map<String, dynamic> json) => SiteAttendBy(
    id: json["id"],
    attendenceId: json["attendence_id"],
    workReportId: json["work_report_id"],
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "work_report_id": workReportId,
    "user_id": userId,
    "user_name": userName,
  };
}
