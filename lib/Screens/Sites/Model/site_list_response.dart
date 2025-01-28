// To parse this JSON data, do
//
//     final siteListResponse = siteListResponseFromJson(jsonString);

import 'dart:convert';

SiteListResponse siteListResponseFromJson(String str) => SiteListResponse.fromJson(json.decode(str));

String siteListResponseToJson(SiteListResponse data) => json.encode(data.toJson());

class SiteListResponse {
  int? status;
  List<SiteData>? data;

  SiteListResponse({
    this.status,
    this.data,
  });

  factory SiteListResponse.fromJson(Map<String, dynamic> json) => SiteListResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<SiteData>.from(json["data"]!.map((x) => SiteData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SiteData {
  String? sId;
  String? sSiteName;
  String? sSiteAddress;
  String? sSiteToken;
  DateTime? sCreatedAt;

  SiteData({
    this.sId,
    this.sSiteName,
    this.sSiteAddress,
    this.sSiteToken,
    this.sCreatedAt,
  });

  factory SiteData.fromJson(Map<String, dynamic> json) => SiteData(
    sId: json["s_id"],
    sSiteName: json["s_site_name"],
    sSiteAddress: json["s_site_address"],
    sSiteToken: json["s_site_token"],
    sCreatedAt: json["s_created_at"] == null ? null : DateTime.parse(json["s_created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "s_id": sId,
    "s_site_name": sSiteName,
    "s_site_address": sSiteAddress,
    "s_site_token": sSiteToken,
    "s_created_at": sCreatedAt?.toIso8601String(),
  };
}
