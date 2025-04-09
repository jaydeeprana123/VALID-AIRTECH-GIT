// To parse this JSON data, do
//
//     final createAppointmentRequest = createAppointmentRequestFromJson(jsonString);

import 'dart:convert';

CreateAppointmentRequest createAppointmentRequestFromJson(String str) => CreateAppointmentRequest.fromJson(json.decode(str));

String createAppointmentRequestToJson(CreateAppointmentRequest data) => json.encode(data.toJson());

class CreateAppointmentRequest {
  String? id;
  String? date;
  String? headId;
  String? siteId;

  CreateAppointmentRequest({
    this.id,
    this.date,
    this.headId,
    this.siteId,
  });

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) => CreateAppointmentRequest(
    id: json["id"],
    date: json["date"],
    headId: json["head_id"],
    siteId: json["site_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_id": headId,
    "site_id": siteId,
  };
}
