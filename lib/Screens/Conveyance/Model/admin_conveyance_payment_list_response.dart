// To parse this JSON data, do
//
//     final adminConveyancePaymentListResponse = adminConveyancePaymentListResponseFromJson(jsonString);

import 'dart:convert';

AdminConveyancePaymentListResponse adminConveyancePaymentListResponseFromJson(String str) => AdminConveyancePaymentListResponse.fromJson(json.decode(str));

String adminConveyancePaymentListResponseToJson(AdminConveyancePaymentListResponse data) => json.encode(data.toJson());

class AdminConveyancePaymentListResponse {
  bool? status;
  String? message;
  int? code;
  List<AdminConveyancePaymentData>? data;

  AdminConveyancePaymentListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AdminConveyancePaymentListResponse.fromJson(Map<String, dynamic> json) => AdminConveyancePaymentListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AdminConveyancePaymentData>.from(json["data"]!.map((x) => AdminConveyancePaymentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AdminConveyancePaymentData {
  int? id;
  int? adminConveyanceId;
  String? date;
  String? amount;
  String? remark;

  AdminConveyancePaymentData({
    this.id,
    this.adminConveyanceId,
    this.date,
    this.amount,
    this.remark,
  });

  factory AdminConveyancePaymentData.fromJson(Map<String, dynamic> json) => AdminConveyancePaymentData(
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
