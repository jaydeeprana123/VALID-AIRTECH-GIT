// To parse this JSON data, do
//
//     final createOfficeRequest = createOfficeRequestFromJson(jsonString);

import 'dart:convert';

CreateOfficeRequest createOfficeRequestFromJson(String str) => CreateOfficeRequest.fromJson(json.decode(str));

String createOfficeRequestToJson(CreateOfficeRequest data) => json.encode(data.toJson());

class CreateOfficeRequest {
  String? id;
  String? title;

  CreateOfficeRequest({
    this.id,
    this.title,
  });

  factory CreateOfficeRequest.fromJson(Map<String, dynamic> json) => CreateOfficeRequest(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
