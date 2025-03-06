// To parse this JSON data, do
//
//     final headInstrumentResponse = headInstrumentResponseFromJson(jsonString);

import 'dart:convert';

HeadInstrumentResponse headInstrumentResponseFromJson(String str) => HeadInstrumentResponse.fromJson(json.decode(str));

String headInstrumentResponseToJson(HeadInstrumentResponse data) => json.encode(data.toJson());

class HeadInstrumentResponse {
  bool? status;
  String? message;
  int? code;
  List<HeadInstrumentData>? data;

  HeadInstrumentResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory HeadInstrumentResponse.fromJson(Map<String, dynamic> json) => HeadInstrumentResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<HeadInstrumentData>.from(json["data"]!.map((x) => HeadInstrumentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HeadInstrumentData {
  int? id;
  String? name;

  HeadInstrumentData({
    this.id,
    this.name,
  });

  factory HeadInstrumentData.fromJson(Map<String, dynamic> json) => HeadInstrumentData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
