// To parse this JSON data, do
//
//     final calibrationCertificateListResponse = calibrationCertificateListResponseFromJson(jsonString);

import 'dart:convert';

CalibrationCertificateListResponse calibrationCertificateListResponseFromJson(
        String str) =>
    CalibrationCertificateListResponse.fromJson(json.decode(str));

String calibrationCertificateListResponseToJson(
        CalibrationCertificateListResponse data) =>
    json.encode(data.toJson());

class CalibrationCertificateListResponse {
  bool? status;
  String? message;
  int? code;
  List<CalibrationCertificateData>? data;

  CalibrationCertificateListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory CalibrationCertificateListResponse.fromJson(
          Map<String, dynamic> json) =>
      CalibrationCertificateListResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<CalibrationCertificateData>.from(json["data"]!
                .map((x) => CalibrationCertificateData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CalibrationCertificateData {
  int? id;
  String? title;
  String? pdf;

  CalibrationCertificateData({
    this.id,
    this.title,
    this.pdf,
  });

  factory CalibrationCertificateData.fromJson(Map<String, dynamic> json) =>
      CalibrationCertificateData(
        id: json["id"],
        title: json["title"],
        pdf: json["pdf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pdf": pdf,
      };
}
