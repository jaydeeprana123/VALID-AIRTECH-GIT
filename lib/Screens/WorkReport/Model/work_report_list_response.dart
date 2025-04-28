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
  int? attendenceId;
  int? siteId;
  String? contactName;
  String? train;
  String? bus;
  String? auto;
  String? fuel;
  String? foodAmount;
  String? other;
  List<RemarkWorkReport>? remark;
  List<WorkReportExpensesBill>? workReportExpensesBill;

  WorkReportData({
    this.id,
    this.attendenceId,
    this.siteId,
    this.contactName,
    this.train,
    this.bus,
    this.auto,
    this.fuel,
    this.foodAmount,
    this.other,
    this.remark,
    this.workReportExpensesBill,
  });

  factory WorkReportData.fromJson(Map<String, dynamic> json) => WorkReportData(
    id: json["id"],
    attendenceId: json["attendence_id"],
    siteId: json["site_id"],
    contactName: json["contact_name"],
    train: json["train"],
    bus: json["bus"],
    auto: json["auto"],
    fuel: json["fuel"],
    foodAmount: json["food_amount"],
    other: json["other"],
    remark: json["remark"] == null ? [] : List<RemarkWorkReport>.from(json["remark"]!.map((x) => RemarkWorkReport.fromJson(x))),
    workReportExpensesBill: json["workReportExpensesBill"] == null ? [] : List<WorkReportExpensesBill>.from(json["workReportExpensesBill"]!.map((x) => WorkReportExpensesBill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "site_id": siteId,
    "contact_name": contactName,
    "train": train,
    "bus": bus,
    "auto": auto,
    "fuel": fuel,
    "food_amount": foodAmount,
    "other": other,
    "remark": remark == null ? [] : List<dynamic>.from(remark!.map((x) => x.toJson())),
    "workReportExpensesBill": workReportExpensesBill == null ? [] : List<dynamic>.from(workReportExpensesBill!.map((x) => x.toJson())),
  };
}

class RemarkWorkReport {
  int? id;
  int? attendenceId;
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

class WorkReportExpensesBill {
  int? id;
  int? attendenceId;
  int? workReportId;
  String? photo;
  String? billName;
  String? path;
  TextEditingController billNameTextEditingController = TextEditingController();

  WorkReportExpensesBill({
    this.id,
    this.attendenceId,
    this.workReportId,
    this.photo,
    this.billName,
  });

  factory WorkReportExpensesBill.fromJson(Map<String, dynamic> json) => WorkReportExpensesBill(
    id: json["id"],
    attendenceId: json["attendence_id"],
    workReportId: json["work_report_id"],
    photo: json["photo"],
    billName: json["bill_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attendence_id": attendenceId,
    "work_report_id": workReportId,
    "photo": photo,
    "bill_name": billName,
  };
}
