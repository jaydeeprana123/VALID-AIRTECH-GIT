// To parse this JSON data, do
//
//     final homeAllowanceListResponse = homeAllowanceListResponseFromJson(jsonString);

import 'dart:convert';

HomeAllowanceListResponse homeAllowanceListResponseFromJson(String str) => HomeAllowanceListResponse.fromJson(json.decode(str));

String homeAllowanceListResponseToJson(HomeAllowanceListResponse data) => json.encode(data.toJson());

class HomeAllowanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<HomeAllowanceData>? data;

  HomeAllowanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory HomeAllowanceListResponse.fromJson(Map<String, dynamic> json) => HomeAllowanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<HomeAllowanceData>.from(json["data"]!.map((x) => HomeAllowanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HomeAllowanceData {
  int? id;
  String? date;
  int? allowanceId;
  String? allowanceName;
  int? workmanId;
  String? workmanName;
  String? amount;

  HomeAllowanceData({
    this.id,
    this.date,
    this.allowanceId,
    this.allowanceName,
    this.workmanId,
    this.workmanName,
    this.amount,
  });

  factory HomeAllowanceData.fromJson(Map<String, dynamic> json) => HomeAllowanceData(
    id: json["id"],
    date: json["date"],
    allowanceId: json["allowance_id"],
    allowanceName: json["allowance_name"],
    workmanId: json["workman_id"],
    workmanName: json["workman_name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "allowance_id": allowanceId,
    "allowance_name": allowanceName,
    "workman_id": workmanId,
    "workman_name": workmanName,
    "amount": amount,
  };
}
