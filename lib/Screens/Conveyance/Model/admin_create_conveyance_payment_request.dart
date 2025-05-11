// To parse this JSON data, do
//
//     final adminCreateConveyancePaymentRequest = adminCreateConveyancePaymentRequestFromJson(jsonString);

import 'dart:convert';

AdminCreateConveyancePaymentRequest adminCreateConveyancePaymentRequestFromJson(String str) => AdminCreateConveyancePaymentRequest.fromJson(json.decode(str));

String adminCreateConveyancePaymentRequestToJson(AdminCreateConveyancePaymentRequest data) => json.encode(data.toJson());

class AdminCreateConveyancePaymentRequest {
  String? id;
  String? adminConveyanceId;
  String? date;
  String? amount;
  String? remark;

  AdminCreateConveyancePaymentRequest({
    this.id,
    this.adminConveyanceId,
    this.date,
    this.amount,
    this.remark,
  });

  factory AdminCreateConveyancePaymentRequest.fromJson(Map<String, dynamic> json) => AdminCreateConveyancePaymentRequest(
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
