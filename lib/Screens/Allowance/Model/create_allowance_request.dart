// To parse this JSON data, do
//
//     final createAllowanceRequest = createAllowanceRequestFromJson(jsonString);

import 'dart:convert';

CreateAllowanceRequest createAllowanceRequestFromJson(String str) => CreateAllowanceRequest.fromJson(json.decode(str));

String createAllowanceRequestToJson(CreateAllowanceRequest data) => json.encode(data.toJson());

class CreateAllowanceRequest {
  String? id;
  String? name;
  String? status;

  CreateAllowanceRequest({
    this.id,
    this.name,
    this.status,
  });

  factory CreateAllowanceRequest.fromJson(Map<String, dynamic> json) => CreateAllowanceRequest(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}
