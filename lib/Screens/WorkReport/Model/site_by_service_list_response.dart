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
  List<SiteAttendByData>? data;

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
    data: json["data"] == null ? [] : List<SiteAttendByData>.from(json["data"]!.map((x) => SiteAttendByData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SiteAttendByData {
  int? id;
  int? mainId;
  String? name;
  bool isSelected = false;

  SiteAttendByData({
    this.id,
    this.mainId,
    this.name,
  });

  factory SiteAttendByData.fromJson(Map<String, dynamic> json) => SiteAttendByData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SiteAttendByData &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name ?? '';
}
