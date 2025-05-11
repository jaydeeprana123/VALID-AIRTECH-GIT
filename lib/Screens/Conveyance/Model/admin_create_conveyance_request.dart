// To parse this JSON data, do
//
//     final adminCreateConveyanceRequest = adminCreateConveyanceRequestFromJson(jsonString);

import 'dart:convert';

AdminCreateConveyanceRequest adminCreateConveyanceRequestFromJson(String str) => AdminCreateConveyanceRequest.fromJson(json.decode(str));

String adminCreateConveyanceRequestToJson(AdminCreateConveyanceRequest data) => json.encode(data.toJson());

class AdminCreateConveyanceRequest {
  String? id;
  String? date;
  String? headConveyanceId;
  String? conveyanceId;
  String? headId;
  String? amount;

  AdminCreateConveyanceRequest({
    this.id,
    this.date,
    this.headConveyanceId,
    this.conveyanceId,
    this.headId,
    this.amount,
  });

  factory AdminCreateConveyanceRequest.fromJson(Map<String, dynamic> json) => AdminCreateConveyanceRequest(
    id: json["id"],
    date: json["date"],
    headConveyanceId: json["head_conveyance_id"],
    conveyanceId: json["conveyance_id"],
    headId: json["head_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_conveyance_id": headConveyanceId,
    "conveyance_id": conveyanceId,
    "head_id": headId,
    "amount": amount,
  };
}
