// To parse this JSON data, do
//
//     final driverListResponse = driverListResponseFromJson(jsonString);

import 'dart:convert';

DriverListResponse driverListResponseFromJson(String str) => DriverListResponse.fromJson(json.decode(str));

String driverListResponseToJson(DriverListResponse data) => json.encode(data.toJson());

class DriverListResponse {
  int? status;
  List<DriverData>? data;

  DriverListResponse({
    this.status,
    this.data,
  });

  factory DriverListResponse.fromJson(Map<String, dynamic> json) => DriverListResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<DriverData>.from(json["data"]!.map((x) => DriverData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DriverData {
  String? drId;
  String? drDriverName;
  String? drAddress;
  String? drSuffix;
  List<String>? drPhone;
  List<String>? drPhoneKey;
  String? drTransportId;
  String? drDriverToken;
  String? isDeleted;
  DateTime? drCreatedAt;
  String? tTransportName;

  DriverData({
    this.drId,
    this.drDriverName,
    this.drAddress,
    this.drSuffix,
    this.drPhone,
    this.drPhoneKey,
    this.drTransportId,
    this.drDriverToken,
    this.isDeleted,
    this.drCreatedAt,
    this.tTransportName,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
    drId: json["dr_id"],
    drDriverName: json["dr_driver_name"],
    drAddress: json["dr_address"],
    drSuffix: json["dr_suffix"],
    drPhone: json["dr_phone"] == null ? [] : List<String>.from(json["dr_phone"]!.map((x) => x)),
    drPhoneKey: json["dr_phone_key"] == null ? [] : List<String>.from(json["dr_phone_key"]!..map((x) => x)),
    drTransportId: json["dr_transport_id"],
    drDriverToken: json["dr_driver_token"],
    isDeleted: json["is_deleted"],
    drCreatedAt: json["dr_created_at"] == null ? null : DateTime.parse(json["dr_created_at"]),
    tTransportName: json["t_transport_name"],
  );

  Map<String, dynamic> toJson() => {
    "dr_id": drId,
    "dr_driver_name": drDriverName,
    "dr_address": drAddress,
    "dr_suffix": drSuffix,
    "dr_phone": drPhone == null ? [] : List<dynamic>.from(drPhone!.map((x) => x)),
    "dr_phone_key": drPhoneKey == null ? [] : List<dynamic>.from(drPhoneKey!.map((x) => x)),
    "dr_transport_id": drTransportId,
    "dr_driver_token": drDriverToken,
    "is_deleted": isDeleted,
    "dr_created_at": drCreatedAt?.toIso8601String(),
    "t_transport_name": tTransportName,
  };
}

