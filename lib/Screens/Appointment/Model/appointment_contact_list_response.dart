// To parse this JSON data, do
//
//     final appointmentContactListResponse = appointmentContactListResponseFromJson(jsonString);

import 'dart:convert';

AppointmentContactListResponse appointmentContactListResponseFromJson(String str) => AppointmentContactListResponse.fromJson(json.decode(str));

String appointmentContactListResponseToJson(AppointmentContactListResponse data) => json.encode(data.toJson());

class AppointmentContactListResponse {
  bool? status;
  String? message;
  int? code;
  List<AppointmentContactData>? data;

  AppointmentContactListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AppointmentContactListResponse.fromJson(Map<String, dynamic> json) => AppointmentContactListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AppointmentContactData>.from(json["data"]!.map((x) => AppointmentContactData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AppointmentContactData {
  int? id;
  int? headId;
  String? headName;
  String? headAddress;
  String? sufix;
  String? contactName;
  String? departmentName;
  String? email;
  List<Contact>? contact;

  AppointmentContactData({
    this.id,
    this.headId,
    this.headName,
    this.headAddress,
    this.sufix,
    this.contactName,
    this.departmentName,
    this.email,
    this.contact,
  });

  factory AppointmentContactData.fromJson(Map<String, dynamic> json) => AppointmentContactData(
    id: json["id"],
    headId: json["head_id"],
    headName: json["head_name"],
    headAddress: json["head_address"],
    sufix: json["sufix"],
    contactName: json["contact_name"],
    departmentName: json["department_name"],
    email: json["email"],
    contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_id": headId,
    "head_name": headName,
    "head_address": headAddress,
    "sufix": sufix,
    "contact_name": contactName,
    "department_name": departmentName,
    "email": email,
    "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
  };
}

class Contact {
  int? id;
  int? siteId;
  int? contactType;
  String? contactTypeName;
  String? mobileNo;
  String? telephone;

  Contact({
    this.id,
    this.siteId,
    this.contactType,
    this.contactTypeName,
    this.mobileNo,
    this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    siteId: json["site_id"],
    contactType: json["contact_type"],
    contactTypeName: json["contact_type_name"],
    mobileNo: json["mobile_no"],
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_id": siteId,
    "contact_type": contactType,
    "contact_type_name": contactTypeName,
    "mobile_no": mobileNo,
    "telephone": telephone,
  };
}
