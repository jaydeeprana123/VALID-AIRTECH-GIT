// To parse this JSON data, do
//
//     final allowanceListResponse = allowanceListResponseFromJson(jsonString);

import 'dart:convert';

AllowanceListResponse allowanceListResponseFromJson(String str) => AllowanceListResponse.fromJson(json.decode(str));

String allowanceListResponseToJson(AllowanceListResponse data) => json.encode(data.toJson());

class AllowanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<AllowanceData>? data;

  AllowanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AllowanceListResponse.fromJson(Map<String, dynamic> json) => AllowanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AllowanceData>.from(json["data"]!.map((x) => AllowanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllowanceData {
  int? id;
  String? name;
  int? status;
  String? statusType;

  AllowanceData({
    this.id,
    this.name,
    this.status,
    this.statusType,
  });

  factory AllowanceData.fromJson(Map<String, dynamic> json) => AllowanceData(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "status_type": statusType,
  };
}
