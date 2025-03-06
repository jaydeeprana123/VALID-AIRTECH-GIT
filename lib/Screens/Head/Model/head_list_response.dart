// To parse this JSON data, do
//
//     final headListResponse = headListResponseFromJson(jsonString);

import 'dart:convert';

HeadListResponse headListResponseFromJson(String str) => HeadListResponse.fromJson(json.decode(str));

String headListResponseToJson(HeadListResponse data) => json.encode(data.toJson());

class HeadListResponse {
  bool? status;
  String? message;
  int? code;
  List<HeadData>? data;

  HeadListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory HeadListResponse.fromJson(Map<String, dynamic> json) => HeadListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<HeadData>.from(json["data"]!.map((x) => HeadData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HeadData {
  int? id;
  String? name;
  dynamic address;

  HeadData({
    this.id,
    this.name,
    this.address,
  });

  factory HeadData.fromJson(Map<String, dynamic> json) => HeadData(
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
