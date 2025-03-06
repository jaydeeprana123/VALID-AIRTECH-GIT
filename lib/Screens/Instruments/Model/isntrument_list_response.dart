// To parse this JSON data, do
//
//     final instrumentListResponse = instrumentListResponseFromJson(jsonString);

import 'dart:convert';

InstrumentListResponse instrumentListResponseFromJson(String str) => InstrumentListResponse.fromJson(json.decode(str));

String instrumentListResponseToJson(InstrumentListResponse data) => json.encode(data.toJson());

class InstrumentListResponse {
  bool? status;
  String? message;
  int? code;
  List<InstrumentData>? data;

  InstrumentListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory InstrumentListResponse.fromJson(Map<String, dynamic> json) => InstrumentListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<InstrumentData>.from(json["data"]!.map((x) => InstrumentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class InstrumentData {
  int? id;
  int? headInstrumentId;
  String? headInstrumentName;
  String? instrumentIdNo;
  String? modelNo;
  String? srNo;
  String? make;

  InstrumentData({
    this.id,
    this.headInstrumentId,
    this.headInstrumentName,
    this.instrumentIdNo,
    this.modelNo,
    this.srNo,
    this.make,
  });

  factory InstrumentData.fromJson(Map<String, dynamic> json) => InstrumentData(
    id: json["id"],
    headInstrumentId: json["head_instrument_id"],
    headInstrumentName: json["head_instrument_name"],
    instrumentIdNo: json["instrument_id_no"],
    modelNo: json["model_no"],
    srNo: json["sr_no"],
    make: json["make"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_instrument_id": headInstrumentId,
    "head_instrument_name": headInstrumentName,
    "instrument_id_no": instrumentIdNo,
    "model_no": modelNo,
    "sr_no": srNo,
    "make": make,
  };
}
