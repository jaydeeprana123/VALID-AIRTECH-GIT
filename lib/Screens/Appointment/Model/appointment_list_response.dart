// To parse this JSON data, do
//
//     final appointmentListResponse = appointmentListResponseFromJson(jsonString);

import 'dart:convert';

AppointmentListResponse appointmentListResponseFromJson(String str) => AppointmentListResponse.fromJson(json.decode(str));

String appointmentListResponseToJson(AppointmentListResponse data) => json.encode(data.toJson());

class AppointmentListResponse {
  bool? status;
  String? message;
  int? code;
  List<AppointmentData>? data;

  AppointmentListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) => AppointmentListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<AppointmentData>.from(json["data"]!.map((x) => AppointmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AppointmentData {
  int? id;
  String? date;
  int? headId;
  int? siteId;
  Head? head;
  Site? site;

  AppointmentData({
    this.id,
    this.date,
    this.headId,
    this.siteId,
    this.head,
    this.site,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) => AppointmentData(
    id: json["id"],
    date: json["date"],
    headId: json["head_id"],
    siteId: json["site_id"],
    head: json["head"] == null ? null : Head.fromJson(json["head"]),
    site: json["site"] == null ? null : Site.fromJson(json["site"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_id": headId,
    "site_id": siteId,
    "head": head?.toJson(),
    "site": site?.toJson(),
  };
}

class Head {
  int? id;
  String? name;
  String? address;

  Head({
    this.id,
    this.name,
    this.address,
  });

  factory Head.fromJson(Map<String, dynamic> json) => Head(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}

class Site {
  int? id;
  String? headAddress;
  String? sufix;
  String? contactName;
  String? departmentName;
  String? email;

  Site({
    this.id,
    this.headAddress,
    this.sufix,
    this.contactName,
    this.departmentName,
    this.email,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    id: json["id"],
    headAddress: json["head_address"],
    sufix: json["sufix"],
    contactName: json["contact_name"],
    departmentName: json["department_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_address": headAddress,
    "sufix": sufix,
    "contact_name": contactName,
    "department_name": departmentName,
    "email": email,
  };
}
