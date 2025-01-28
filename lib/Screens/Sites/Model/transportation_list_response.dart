// To parse this JSON data, do
//
//     final transportationListResponse = transportationListResponseFromJson(jsonString);

import 'dart:convert';

TransportationListResponse transportationListResponseFromJson(String str) => TransportationListResponse.fromJson(json.decode(str));

String transportationListResponseToJson(TransportationListResponse data) => json.encode(data.toJson());

class TransportationListResponse {
  int? status;
  List<TransportationData>? data;

  TransportationListResponse({
    this.status,
    this.data,
  });

  factory TransportationListResponse.fromJson(Map<String, dynamic> json) => TransportationListResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<TransportationData>.from(json["data"]!.map((x) => TransportationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TransportationData {
  String? tId;
  String? tTransportName;
  String? tTransportToken;
  DateTime? tCreatedAt;

  TransportationData({
    this.tId,
    this.tTransportName,
    this.tTransportToken,
    this.tCreatedAt,
  });

  factory TransportationData.fromJson(Map<String, dynamic> json) => TransportationData(
    tId: json["t_id"],
    tTransportName: json["t_transport_name"],
    tTransportToken: json["t_transport_token"],
    tCreatedAt: json["t_created_at"] == null ? null : DateTime.parse(json["t_created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "t_id": tId,
    "t_transport_name": tTransportName,
    "t_transport_token": tTransportToken,
    "t_created_at": tCreatedAt?.toIso8601String(),
  };
}
