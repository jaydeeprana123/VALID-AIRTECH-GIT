// To parse this JSON data, do
//
//     final headConveyanceListResponse = headConveyanceListResponseFromJson(jsonString);

import 'dart:convert';

HeadConveyanceListResponse headConveyanceListResponseFromJson(String str) => HeadConveyanceListResponse.fromJson(json.decode(str));

String headConveyanceListResponseToJson(HeadConveyanceListResponse data) => json.encode(data.toJson());

class HeadConveyanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<HeadConveyanceData>? data;

  HeadConveyanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory HeadConveyanceListResponse.fromJson(Map<String, dynamic> json) => HeadConveyanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<HeadConveyanceData>.from(json["data"]!.map((x) => HeadConveyanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HeadConveyanceData {
  int? id;
  String? name;

  HeadConveyanceData({
    this.id,
    this.name,
  });

  factory HeadConveyanceData.fromJson(Map<String, dynamic> json) => HeadConveyanceData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
