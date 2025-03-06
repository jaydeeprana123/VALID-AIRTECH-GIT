// To parse this JSON data, do
//
//     final serviceListResponse = serviceListResponseFromJson(jsonString);

import 'dart:convert';

ServiceListResponse serviceListResponseFromJson(String str) => ServiceListResponse.fromJson(json.decode(str));

String serviceListResponseToJson(ServiceListResponse data) => json.encode(data.toJson());

class ServiceListResponse {
  bool? status;
  String? message;
  int? code;
  List<ServiceData>? data;

  ServiceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) => ServiceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<ServiceData>.from(json["data"]!.map((x) => ServiceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ServiceData {
  int? id;
  String? testName;
  String? testCode;

  ServiceData({
    this.id,
    this.testName,
    this.testCode,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    id: json["id"],
    testName: json["test_name"],
    testCode: json["test_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "test_name": testName,
    "test_code": testCode,
  };
}
