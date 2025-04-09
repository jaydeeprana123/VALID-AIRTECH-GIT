// To parse this JSON data, do
//
//     final createHomeAllowanceRequest = createHomeAllowanceRequestFromJson(jsonString);

import 'dart:convert';

CreateHomeAllowanceRequest createHomeAllowanceRequestFromJson(String str) => CreateHomeAllowanceRequest.fromJson(json.decode(str));

String createHomeAllowanceRequestToJson(CreateHomeAllowanceRequest data) => json.encode(data.toJson());

class CreateHomeAllowanceRequest {
  String? id;
  String? date;
  String? allowanceId;
  String? workmanId;
  String? amount;

  CreateHomeAllowanceRequest({
    this.id,
    this.date,
    this.allowanceId,
    this.workmanId,
    this.amount,
  });

  factory CreateHomeAllowanceRequest.fromJson(Map<String, dynamic> json) => CreateHomeAllowanceRequest(
    id: json["id"],
    date: json["date"],
    allowanceId: json["allowance_id"],
    workmanId: json["workman_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "allowance_id": allowanceId,
    "workman_id": workmanId,
    "amount": amount,
  };
}
