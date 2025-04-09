// To parse this JSON data, do
//
//     final planningListResponse = planningListResponseFromJson(jsonString);

import 'dart:convert';

PlanningListResponse planningListResponseFromJson(String str) => PlanningListResponse.fromJson(json.decode(str));

String planningListResponseToJson(PlanningListResponse data) => json.encode(data.toJson());

class PlanningListResponse {
  bool? status;
  String? message;
  int? code;
  List<PlanningData>? data;

  PlanningListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory PlanningListResponse.fromJson(Map<String, dynamic> json) => PlanningListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<PlanningData>.from(json["data"]!.map((x) => PlanningData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PlanningData {
  int? id;
  String? date;
  int? headId;
  int? siteId;
  String? headName;
  String? headAddress;
  String? siteHeadAddress;
  String? siteSufix;
  String? headContactName;
  String? headDepartmentName;
  String? headEmail;
  List<Workman>? workman;
  List<Conveyance>? conveyance;
  List<Instrument>? instrument;
  List<Planning>? planning;
  List<Note>? note;

  PlanningData({
    this.id,
    this.date,
    this.headId,
    this.siteId,
    this.headName,
    this.headAddress,
    this.siteHeadAddress,
    this.siteSufix,
    this.headContactName,
    this.headDepartmentName,
    this.headEmail,
    this.workman,
    this.conveyance,
    this.instrument,
    this.planning,
    this.note,
  });

  factory PlanningData.fromJson(Map<String, dynamic> json) => PlanningData(
    id: json["id"],
    date: json["date"],
    headId: json["head_id"],
    siteId: json["site_id"],
    headName: json["head_name"],
    headAddress: json["head_address"],
    siteHeadAddress: json["site_head_address"],
    siteSufix: json["site_sufix"],
    headContactName: json["head_contact_name"],
    headDepartmentName: json["head_department_name"],
    headEmail: json["head_email"],
    workman: json["workman"] == null ? [] : List<Workman>.from(json["workman"]!.map((x) => Workman.fromJson(x))),
    conveyance: json["conveyance"] == null ? [] : List<Conveyance>.from(json["conveyance"]!.map((x) => Conveyance.fromJson(x))),
    instrument: json["instrument"] == null ? [] : List<Instrument>.from(json["instrument"]!.map((x) => Instrument.fromJson(x))),
    planning: json["planning"] == null ? [] : List<Planning>.from(json["planning"]!.map((x) => Planning.fromJson(x))),
    note: json["note"] == null ? [] : List<Note>.from(json["note"]!.map((x) => Note.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_id": headId,
    "site_id": siteId,
    "head_name": headName,
    "head_address": headAddress,
    "site_head_address": siteHeadAddress,
    "site_sufix": siteSufix,
    "head_contact_name": headContactName,
    "head_department_name": headDepartmentName,
    "head_email": headEmail,
    "workman": workman == null ? [] : List<dynamic>.from(workman!.map((x) => x.toJson())),
    "conveyance": conveyance == null ? [] : List<dynamic>.from(conveyance!.map((x) => x.toJson())),
    "instrument": instrument == null ? [] : List<dynamic>.from(instrument!.map((x) => x.toJson())),
    "planning": planning == null ? [] : List<dynamic>.from(planning!.map((x) => x.toJson())),
    "note": note == null ? [] : List<dynamic>.from(note!.map((x) => x.toJson())),
  };
}

class Conveyance {
  int? id;
  int? planningId;
  int? headId;
  String? headName;
  int? conveyanceId;
  String? conveyanceName;

  Conveyance({
    this.id,
    this.planningId,
    this.headId,
    this.headName,
    this.conveyanceId,
    this.conveyanceName,
  });

  factory Conveyance.fromJson(Map<String, dynamic> json) => Conveyance(
    id: json["id"],
    planningId: json["planning_id"],
    headId: json["head_id"],
    headName: json["head_name"],
    conveyanceId: json["conveyance_id"],
    conveyanceName: json["conveyance_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "head_id": headId,
    "head_name": headName,
    "conveyance_id": conveyanceId,
    "conveyance_name": conveyanceName,
  };
}

class Instrument {
  int? id;
  int? planningId;
  int? headId;
  String? headName;
  int? instrumentId;
  String? instrumentIdNo;
  String? instrumentModelNo;
  String? instrumentSrNo;
  String? instrumentMake;

  Instrument({
    this.id,
    this.planningId,
    this.headId,
    this.headName,
    this.instrumentId,
    this.instrumentIdNo,
    this.instrumentModelNo,
    this.instrumentSrNo,
    this.instrumentMake,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) => Instrument(
    id: json["id"],
    planningId: json["planning_id"],
    headId: json["head_id"],
    headName: json["head_name"],
    instrumentId: json["instrument_id"],
    instrumentIdNo: json["instrument_id_no"],
    instrumentModelNo: json["instrument_model_no"],
    instrumentSrNo: json["instrument_sr_no"],
    instrumentMake: json["instrument_make"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "head_id": headId,
    "head_name": headName,
    "instrument_id": instrumentId,
    "instrument_id_no": instrumentIdNo,
    "instrument_model_no": instrumentModelNo,
    "instrument_sr_no": instrumentSrNo,
    "instrument_make": instrumentMake,
  };
}

class Note {
  int? id;
  int? planningId;
  String? title;

  Note({
    this.id,
    this.planningId,
    this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    planningId: json["planning_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "title": title,
  };
}

class Planning {
  int? id;
  int? planningId;
  String? location;
  List<System>? system;

  Planning({
    this.id,
    this.planningId,
    this.location,
    this.system,
  });

  factory Planning.fromJson(Map<String, dynamic> json) => Planning(
    id: json["id"],
    planningId: json["planning_id"],
    location: json["location"],
    system: json["system"] == null ? [] : List<System>.from(json["system"]!.map((x) => System.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "location": location,
    "system": system == null ? [] : List<dynamic>.from(system!.map((x) => x.toJson())),
  };
}

class System {
  int? id;
  int? planningId;
  int? planningLocationId;
  String? title;
  List<Service>? service;

  System({
    this.id,
    this.planningId,
    this.planningLocationId,
    this.title,
    this.service,
  });

  factory System.fromJson(Map<String, dynamic> json) => System(
    id: json["id"],
    planningId: json["planning_id"],
    planningLocationId: json["planning_location_id "],
    title: json["title"],
    service: json["service"] == null ? [] : List<Service>.from(json["service"]!.map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "planning_location_id ": planningLocationId,
    "title": title,
    "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
  };
}

class Service {
  int? id;
  int? planningId;
  int? planningLocationId;
  int? planningLocationSystemId;
  int? serviceId;
  String? serviceTestName;
  String? serviceTestCode;

  Service({
    this.id,
    this.planningId,
    this.planningLocationId,
    this.planningLocationSystemId,
    this.serviceId,
    this.serviceTestName,
    this.serviceTestCode,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    planningId: json["planning_id"],
    planningLocationId: json["planning_location_id "],
    planningLocationSystemId: json["planning_location_system_id "],
    serviceId: json["service_id "],
    serviceTestName: json["service_test_name"],
    serviceTestCode: json["service_test_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "planning_location_id ": planningLocationId,
    "planning_location_system_id ": planningLocationSystemId,
    "service_id ": serviceId,
    "service_test_name": serviceTestName,
    "service_test_code": serviceTestCode,
  };
}

class Workman {
  int? id;
  int? planningId;
  int? workmanId;
  String? workmanName;

  Workman({
    this.id,
    this.planningId,
    this.workmanId,
    this.workmanName,
  });

  factory Workman.fromJson(Map<String, dynamic> json) => Workman(
    id: json["id"],
    planningId: json["planning_id"],
    workmanId: json["workman_id"],
    workmanName: json["workman_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planning_id": planningId,
    "workman_id": workmanId,
    "workman_name": workmanName,
  };
}
