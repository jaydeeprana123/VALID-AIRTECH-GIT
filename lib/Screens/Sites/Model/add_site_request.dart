// To parse this JSON data, do
//
//     final addSiteRequest = addSiteRequestFromJson(jsonString);

import 'dart:convert';

AddSiteRequest addSiteRequestFromJson(String str) => AddSiteRequest.fromJson(json.decode(str));

String addSiteRequestToJson(AddSiteRequest data) => json.encode(data.toJson());

class AddSiteRequest {
  String? siteName;
  String? siteAddress;
  String? siteToken;

  AddSiteRequest({
    this.siteName,
    this.siteAddress,
    this.siteToken,
  });

  factory AddSiteRequest.fromJson(Map<String, dynamic> json) => AddSiteRequest(
    siteName: json["site_name"],
    siteAddress: json["site_address"],
    siteToken: json["site_token"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName,
    "site_address": siteAddress,
    "site_token": siteToken,
  };
}
