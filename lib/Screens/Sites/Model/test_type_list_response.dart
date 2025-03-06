// To parse this JSON data, do
//
//     final testTypeListResponse = testTypeListResponseFromJson(jsonString);

import 'dart:convert';

TestTypeListResponse testTypeListResponseFromJson(String str) => TestTypeListResponse.fromJson(json.decode(str));

String testTypeListResponseToJson(TestTypeListResponse data) => json.encode(data.toJson());

class TestTypeListResponse {
  int? status;
  List<TestTypeData>? data;

  TestTypeListResponse({
    this.status,
    this.data,
  });

  factory TestTypeListResponse.fromJson(Map<String, dynamic> json) => TestTypeListResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<TestTypeData>.from(json["data"]!.map((x) => TestTypeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TestTypeData {
  String? tId;
  String? tTestName;
  String? tTestCode;
  String? tTestToken;
  DateTime? tCreatedAt;

  TestTypeData({
    this.tId,
    this.tTestName,
    this.tTestCode,
    this.tTestToken,
    this.tCreatedAt,
  });

  factory TestTypeData.fromJson(Map<String, dynamic> json) => TestTypeData(
    tId: json["t_id"],
    tTestName: json["t_test_name"],
    tTestCode: json["t_test_code"],
    tTestToken: json["t_test_token"],
    tCreatedAt: json["t_created_at"] == null ? null : DateTime.parse(json["t_created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "t_id": tId,
    "t_test_name": tTestName,
    "t_test_code": tTestCode,
    "t_test_token": tTestToken,
    "t_created_at": tCreatedAt?.toIso8601String(),
  };
}
