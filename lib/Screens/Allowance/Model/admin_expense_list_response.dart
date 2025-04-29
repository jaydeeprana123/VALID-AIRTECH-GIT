// To parse this JSON data, do
//
//     final adminExpenseListResponse = adminExpenseListResponseFromJson(jsonString);

import 'dart:convert';

AdminExpenseListResponse adminExpenseListResponseFromJson(String str) => AdminExpenseListResponse.fromJson(json.decode(str));

String adminExpenseListResponseToJson(AdminExpenseListResponse data) => json.encode(data.toJson());

class AdminExpenseListResponse {
  bool? status;
  String? message;
  int? code;
  List<AdminExpenseData>? data;

  AdminExpenseListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AdminExpenseListResponse.fromJson(Map<String, dynamic> json) => AdminExpenseListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AdminExpenseData>.from(json["data"]!.map((x) => AdminExpenseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AdminExpenseData {
  int? id;
  int? empId;
  String? empName;
  String? date;
  int? attendenceId;
  int? siteId;
  String? contactName;
  String? train;
  String? bus;
  String? auto;
  String? fuel;
  String? foodAmount;
  String? other;

  AdminExpenseData({
    this.id,
    this.empId,
    this.empName,
    this.date,
    this.attendenceId,
    this.siteId,
    this.contactName,
    this.train,
    this.bus,
    this.auto,
    this.fuel,
    this.foodAmount,
    this.other,
  });

  factory AdminExpenseData.fromJson(Map<String, dynamic> json) => AdminExpenseData(
    id: json["id"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    date: json["date"],
    attendenceId: json["attendence_id"],
    siteId: json["site_id"],
    contactName: json["contact_name"],
    train: json["train"],
    bus: json["bus"],
    auto: json["auto"],
    fuel: json["fuel"],
    foodAmount: json["food_amount"],
    other: json["other"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "emp_name": empName,
    "date": date,
    "attendence_id": attendenceId,
    "site_id": siteId,
    "contact_name": contactName,
    "train": train,
    "bus": bus,
    "auto": auto,
    "fuel": fuel,
    "food_amount": foodAmount,
    "other": other,
  };
}
