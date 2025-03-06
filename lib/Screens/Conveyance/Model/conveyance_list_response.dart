// To parse this JSON data, do
//
//     final conveyanceListResponse = conveyanceListResponseFromJson(jsonString);

import 'dart:convert';

ConveyanceListResponse conveyanceListResponseFromJson(String str) => ConveyanceListResponse.fromJson(json.decode(str));

String conveyanceListResponseToJson(ConveyanceListResponse data) => json.encode(data.toJson());

class ConveyanceListResponse {
  bool? status;
  String? message;
  int? code;
  List<ConveyanceData>? data;

  ConveyanceListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory ConveyanceListResponse.fromJson(Map<String, dynamic> json) => ConveyanceListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<ConveyanceData>.from(json["data"]!.map((x) => ConveyanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ConveyanceData {
  int? id;
  int? headConveyanceId;
  String? headConveyanceName;
  String? name;
  String? sufix;
  String? address;
  List<Contact>? contact;

  ConveyanceData({
    this.id,
    this.headConveyanceId,
    this.headConveyanceName,
    this.name,
    this.sufix,
    this.address,
    this.contact,
  });

  factory ConveyanceData.fromJson(Map<String, dynamic> json) => ConveyanceData(
    id: json["id"],
    headConveyanceId: json["head_conveyance_id"],
    headConveyanceName: json["head_conveyance_name"],
    name: json["name"],
    sufix: json["sufix"],
    address: json["address"],
    contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_conveyance_id": headConveyanceId,
    "head_conveyance_name": headConveyanceName,
    "name": name,
    "sufix": sufix,
    "address": address,
    "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
  };
}

class Contact {
  int? id;
  int? conveyanceId;
  int? contactType;
  String? contactTypeName;
  String? mobileNo;
  String? telephone;

  Contact({
    this.id,
    this.conveyanceId,
    this.contactType,
    this.contactTypeName,
    this.mobileNo,
    this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    conveyanceId: json["conveyance_id"],
    contactType: json["contact_type"],
    contactTypeName: json["contact_type_name"],
    mobileNo: json["mobile_no"],
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conveyance_id": conveyanceId,
    "contact_type": contactType,
    "contact_type_name": contactTypeName,
    "mobile_no": mobileNo,
    "telephone": telephone,
  };
}
