// To parse this JSON data, do
//
//     final officeListResponse = officeListResponseFromJson(jsonString);

import 'dart:convert';

OfficeListResponse officeListResponseFromJson(String str) => OfficeListResponse.fromJson(json.decode(str));

String officeListResponseToJson(OfficeListResponse data) => json.encode(data.toJson());

class OfficeListResponse {
  bool? status;
  String? message;
  int? code;
  List<OfficeData>? data;

  OfficeListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory OfficeListResponse.fromJson(Map<String, dynamic> json) => OfficeListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<OfficeData>.from(json["data"]!.map((x) => OfficeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OfficeData {
  int? id;
  String? title;

  OfficeData({
    this.id,
    this.title,
  });

  factory OfficeData.fromJson(Map<String, dynamic> json) => OfficeData(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
