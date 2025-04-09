// To parse this JSON data, do
//
//     final circularListResponse = circularListResponseFromJson(jsonString);

import 'dart:convert';

CircularListResponse circularListResponseFromJson(String str) => CircularListResponse.fromJson(json.decode(str));

String circularListResponseToJson(CircularListResponse data) => json.encode(data.toJson());

class CircularListResponse {
  bool? status;
  String? message;
  int? code;
  List<CircularData>? data;

  CircularListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory CircularListResponse.fromJson(Map<String, dynamic> json) => CircularListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<CircularData>.from(json["data"]!.map((x) => CircularData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CircularData {
  int? id;
  int? empId;
  String? date;
  String? title;
  String? pdf;

  CircularData({
    this.id,
    this.empId,
    this.date,
    this.title,
    this.pdf,
  });

  factory CircularData.fromJson(Map<String, dynamic> json) => CircularData(
    id: json["id"],
    empId: json["emp_id"],
    date: json["date"],
    title: json["title"],
    pdf: json["pdf"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "date": date,
    "title": title,
    "pdf": pdf,
  };
}
