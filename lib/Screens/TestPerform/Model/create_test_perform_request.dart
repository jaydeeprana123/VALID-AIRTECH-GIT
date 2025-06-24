// To parse this JSON data, do
//
//     final createServiceRequest = createServiceRequestFromJson(jsonString);

import 'dart:convert';

CreateTestPerformRequest createServiceRequestFromJson(String str) => CreateTestPerformRequest.fromJson(json.decode(str));

String createTestPerformRequestToJson(CreateTestPerformRequest data) => json.encode(data.toJson());

class CreateTestPerformRequest {
  String? id;
  String? testName;
  String? testCode;

  CreateTestPerformRequest({
    this.id,
    this.testName,
    this.testCode,
  });

  factory CreateTestPerformRequest.fromJson(Map<String, dynamic> json) => CreateTestPerformRequest(
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
