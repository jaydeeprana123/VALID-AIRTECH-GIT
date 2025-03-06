// To parse this JSON data, do
//
//     final createInstrumentRequest = createInstrumentRequestFromJson(jsonString);

import 'dart:convert';

CreateInstrumentRequest createInstrumentRequestFromJson(String str) => CreateInstrumentRequest.fromJson(json.decode(str));

String createInstrumentRequestToJson(CreateInstrumentRequest data) => json.encode(data.toJson());

class CreateInstrumentRequest {
  String? id;
  String? headInstrumentId;
  String? instrumentIdNo;
  String? modelNo;
  String? srNo;
  String? make;

  CreateInstrumentRequest({
    this.id,
    this.headInstrumentId,
    this.instrumentIdNo,
    this.modelNo,
    this.srNo,
    this.make,
  });

  factory CreateInstrumentRequest.fromJson(Map<String, dynamic> json) => CreateInstrumentRequest(
    id: json["id"],
    headInstrumentId: json["head_instrument_id"],
    instrumentIdNo: json["instrument_id_no"],
    modelNo: json["model_no"],
    srNo: json["sr_no"],
    make: json["make"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_instrument_id": headInstrumentId,
    "instrument_id_no": instrumentIdNo,
    "model_no": modelNo,
    "sr_no": srNo,
    "make": make,
  };
}
