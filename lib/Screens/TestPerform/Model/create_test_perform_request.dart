// To parse this JSON data, do
//
//     final createServiceRequest = createServiceRequestFromJson(jsonString);

import 'dart:convert';

CreateServiceRequest createServiceRequestFromJson(String str) => CreateServiceRequest.fromJson(json.decode(str));

String createServiceRequestToJson(CreateServiceRequest data) => json.encode(data.toJson());

class CreateServiceRequest {
  String? id;
  String? testName;
  String? testCode;

  CreateServiceRequest({
    this.id,
    this.testName,
    this.testCode,
  });

  factory CreateServiceRequest.fromJson(Map<String, dynamic> json) => CreateServiceRequest(
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
