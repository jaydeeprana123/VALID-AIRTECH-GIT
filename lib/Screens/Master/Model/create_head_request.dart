// To parse this JSON data, do
//
//     final createHeadRequest = createHeadRequestFromJson(jsonString);

import 'dart:convert';

CreateHeadRequest createHeadRequestFromJson(String str) => CreateHeadRequest.fromJson(json.decode(str));

String createHeadRequestToJson(CreateHeadRequest data) => json.encode(data.toJson());

class CreateHeadRequest {
  String? id;
  String? name;
  String? address;

  CreateHeadRequest({
    this.id,
    this.name,
    this.address,
  });

  factory CreateHeadRequest.fromJson(Map<String, dynamic> json) => CreateHeadRequest(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}
