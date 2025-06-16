// To parse this JSON data, do
//
//     final siteByServiceLIstResponse = siteByServiceLIstResponseFromJson(jsonString);

import 'dart:convert';

SiteByServiceLIstResponse siteByServiceLIstResponseFromJson(String str) => SiteByServiceLIstResponse.fromJson(json.decode(str));

String siteByServiceLIstResponseToJson(SiteByServiceLIstResponse data) => json.encode(data.toJson());

class SiteByServiceLIstResponse {
  bool? status;
  String? message;
  int? code;
  List<SiteByServiceData>? data;

  SiteByServiceLIstResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory SiteByServiceLIstResponse.fromJson(Map<String, dynamic> json) => SiteByServiceLIstResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<SiteByServiceData>.from(json["data"]!.map((x) => SiteByServiceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SiteByServiceData {
  int? id;
  String? name;

  SiteByServiceData({
    this.id,
    this.name,
  });

  factory SiteByServiceData.fromJson(Map<String, dynamic> json) => SiteByServiceData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
