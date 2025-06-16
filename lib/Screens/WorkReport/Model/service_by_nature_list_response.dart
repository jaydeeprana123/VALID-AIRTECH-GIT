// To parse this JSON data, do
//
//     final serviceByNatureResponse = serviceByNatureResponseFromJson(jsonString);

import 'dart:convert';

ServiceByNatureResponse serviceByNatureResponseFromJson(String str) => ServiceByNatureResponse.fromJson(json.decode(str));

String serviceByNatureResponseToJson(ServiceByNatureResponse data) => json.encode(data.toJson());

class ServiceByNatureResponse {
  bool? status;
  String? message;
  int? code;
  List<ServiceByNatureData>? data;

  ServiceByNatureResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory ServiceByNatureResponse.fromJson(Map<String, dynamic> json) => ServiceByNatureResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<ServiceByNatureData>.from(json["data"]!.map((x) => ServiceByNatureData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ServiceByNatureData {
  int? id;
  String? name;

  ServiceByNatureData({
    this.id,
    this.name,
  });

  factory ServiceByNatureData.fromJson(Map<String, dynamic> json) => ServiceByNatureData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
