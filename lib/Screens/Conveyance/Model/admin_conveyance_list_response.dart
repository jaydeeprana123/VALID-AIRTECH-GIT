// To parse this JSON data, do
//
//     final adminConveyanceListResponse = adminConveyanceListResponseFromJson(jsonString);

import 'dart:convert';

AdminConveyanceListResponse adminConveyanceListResponseFromJson(String str) => AdminConveyanceListResponse.fromJson(json.decode(str));

String adminConveyanceListResponseToJson(AdminConveyanceListResponse data) => json.encode(data.toJson());

class AdminConveyanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<AdminConveyanceData>? data;

  AdminConveyanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AdminConveyanceListResponse.fromJson(Map<String, dynamic> json) => AdminConveyanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AdminConveyanceData>.from(json["data"]!.map((x) => AdminConveyanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AdminConveyanceData {
  int? id;
  String? date;
  int? headConveyanceId;
  String? headConveyanceName;
  int? conveyanceId;
  String? conveyanceName;
  int? headId;
  String? headAddress;
  String? amount;
  List<AdminConveyancePayment>? adminConveyancePayment;

  AdminConveyanceData({
    this.id,
    this.date,
    this.headConveyanceId,
    this.headConveyanceName,
    this.conveyanceId,
    this.conveyanceName,
    this.headId,
    this.headAddress,
    this.amount,
    this.adminConveyancePayment,
  });

  factory AdminConveyanceData.fromJson(Map<String, dynamic> json) => AdminConveyanceData(
    id: json["id"],
    date: json["date"],
    headConveyanceId: json["head_conveyance_id"],
    headConveyanceName: json["head_conveyance_name"],
    conveyanceId: json["conveyance_id"],
    conveyanceName: json["conveyance_name"],
    headId: json["head_id"],
    headAddress: json["head_address"],
    amount: json["amount"],
    adminConveyancePayment: json["admin_conveyance_payment"] == null ? [] : List<AdminConveyancePayment>.from(json["admin_conveyance_payment"]!.map((x) => AdminConveyancePayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_conveyance_id": headConveyanceId,
    "head_conveyance_name": headConveyanceName,
    "conveyance_id": conveyanceId,
    "conveyance_name": conveyanceName,
    "head_id": headId,
    "head_address": headAddress,
    "amount": amount,
    "admin_conveyance_payment": adminConveyancePayment == null ? [] : List<dynamic>.from(adminConveyancePayment!.map((x) => x.toJson())),
  };
}

class AdminConveyancePayment {
  int? id;
  int? adminConveyanceId;
  String? date;
  String? amount;
  String? remark;

  AdminConveyancePayment({
    this.id,
    this.adminConveyanceId,
    this.date,
    this.amount,
    this.remark,
  });

  factory AdminConveyancePayment.fromJson(Map<String, dynamic> json) => AdminConveyancePayment(
    id: json["id"],
    adminConveyanceId: json["admin_conveyance_id"],
    date: json["date"],
    amount: json["amount"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_conveyance_id": adminConveyanceId,
    "date": date,
    "amount": amount,
    "remark": remark,
  };
}
