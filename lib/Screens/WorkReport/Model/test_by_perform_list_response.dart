// To parse this JSON data, do
//
//     final testByPerformanceListResponse = testByPerformanceListResponseFromJson(jsonString);

import 'dart:convert';

TestByPerformanceListResponse testByPerformanceListResponseFromJson(String str) => TestByPerformanceListResponse.fromJson(json.decode(str));

String testByPerformanceListResponseToJson(TestByPerformanceListResponse data) => json.encode(data.toJson());

class TestByPerformanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<TestByPerformData>? data;

  TestByPerformanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory TestByPerformanceListResponse.fromJson(Map<String, dynamic> json) => TestByPerformanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<TestByPerformData>.from(json["data"]!.map((x) => TestByPerformData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TestByPerformData {
  int? id;
  String? testName;

  TestByPerformData({
    this.id,
    this.testName,
  });

  factory TestByPerformData.fromJson(Map<String, dynamic> json) => TestByPerformData(
    id: json["id"],
    testName: json["test_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "test_name": testName,
  };
}
