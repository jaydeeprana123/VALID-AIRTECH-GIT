// To parse this JSON data, do
//
//     final addPlanningRequest = addPlanningRequestFromJson(jsonString);

import 'dart:convert';

AddPlanningRequest addPlanningRequestFromJson(String str) => AddPlanningRequest.fromJson(json.decode(str));

String addPlanningRequestToJson(AddPlanningRequest data) => json.encode(data.toJson());

class AddPlanningRequest {
  String? id;
  String? date;
  String? headId;
  String? siteId;
  List<AddWorkman>? workman;
  List<AddConveyanceForPlanning>? conveyance;
  List<AddInstrumentForPlanning>? instrument;
  List<Planning>? planning;
  List<Note>? note;
  List<RemovedWorkman>? removedWorkman;
  List<RemovedConveyance>? removedConveyance;
  List<RemovedInstrument>? removedInstrument;
  List<RemovedNote>? removedNote;
  List<RemovedService>? removedService;
  List<RemovedSystem>? removedSystem;
  List<RemovedPlanning>? removedPlanning;

  AddPlanningRequest({
    this.id,
    this.date,
    this.headId,
    this.siteId,
    this.workman,
    this.conveyance,
    this.instrument,
    this.planning,
    this.note,
    this.removedWorkman,
    this.removedConveyance,
    this.removedInstrument,
    this.removedNote,
    this.removedService,
    this.removedSystem,
    this.removedPlanning,
  });

  factory AddPlanningRequest.fromJson(Map<String, dynamic> json) => AddPlanningRequest(
    id: json["id"],
    date: json["date"],
    headId: json["head_id"],
    siteId: json["site_id"],
    workman: json["workman"] == null ? [] : List<AddWorkman>.from(json["workman"]!.map((x) => AddWorkman.fromJson(x))),
    conveyance: json["conveyance"] == null ? [] : List<AddConveyanceForPlanning>.from(json["conveyance"]!.map((x) => AddConveyanceForPlanning.fromJson(x))),
    instrument: json["instrument"] == null ? [] : List<AddInstrumentForPlanning>.from(json["instrument"]!.map((x) => AddInstrumentForPlanning.fromJson(x))),
    planning: json["planning"] == null ? [] : List<Planning>.from(json["planning"]!.map((x) => Planning.fromJson(x))),
    note: json["note"] == null ? [] : List<Note>.from(json["note"]!.map((x) => Note.fromJson(x))),
    removedWorkman: json["removed_workman"] == null ? [] : List<RemovedWorkman>.from(json["removed_workman"]!.map((x) => RemovedWorkman.fromJson(x))),
    removedConveyance: json["removed_conveyance"] == null ? [] : List<RemovedConveyance>.from(json["removed_conveyance"]!.map((x) => RemovedConveyance.fromJson(x))),
    removedInstrument: json["removed_instrument"] == null ? [] : List<RemovedInstrument>.from(json["removed_instrument"]!.map((x) => RemovedInstrument.fromJson(x))),
    removedNote: json["removed_note"] == null ? [] : List<RemovedNote>.from(json["removed_note"]!.map((x) => RemovedNote.fromJson(x))),
    removedService: json["removed_service"] == null ? [] : List<RemovedService>.from(json["removed_service"]!.map((x) => RemovedService.fromJson(x))),
    removedSystem: json["removed_system"] == null ? [] : List<RemovedSystem>.from(json["removed_system"]!.map((x) => RemovedSystem.fromJson(x))),
    removedPlanning: json["removed_planning"] == null ? [] : List<RemovedPlanning>.from(json["removed_planning"]!.map((x) => RemovedPlanning.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "head_id": headId,
    "site_id": siteId,
    "workman": workman == null ? [] : List<dynamic>.from(workman!.map((x) => x.toJson())),
    "conveyance": conveyance == null ? [] : List<dynamic>.from(conveyance!.map((x) => x.toJson())),
    "instrument": instrument == null ? [] : List<dynamic>.from(instrument!.map((x) => x.toJson())),
    "planning": planning == null ? [] : List<dynamic>.from(planning!.map((x) => x.toJson())),
    "note": note == null ? [] : List<dynamic>.from(note!.map((x) => x.toJson())),
    "removed_workman": removedWorkman == null ? [] : List<dynamic>.from(removedWorkman!.map((x) => x.toJson())),
    "removed_conveyance": removedConveyance == null ? [] : List<dynamic>.from(removedConveyance!.map((x) => x.toJson())),
    "removed_instrument": removedInstrument == null ? [] : List<dynamic>.from(removedInstrument!.map((x) => x.toJson())),
    "removed_note": removedNote == null ? [] : List<dynamic>.from(removedNote!.map((x) => x.toJson())),
    "removed_service": removedService == null ? [] : List<dynamic>.from(removedService!.map((x) => x.toJson())),
    "removed_system": removedSystem == null ? [] : List<dynamic>.from(removedSystem!.map((x) => x.toJson())),
    "removed_planning": removedPlanning == null ? [] : List<dynamic>.from(removedPlanning!.map((x) => x.toJson())),
  };
}

class AddConveyanceForPlanning {
  String? id;
  String? headId;
  String? conveyanceId;

  AddConveyanceForPlanning({
    this.id,
    this.headId,
    this.conveyanceId,
  });

  factory AddConveyanceForPlanning.fromJson(Map<String, dynamic> json) => AddConveyanceForPlanning(
    id: json["id"],
    headId: json["head_id"],
    conveyanceId: json["conveyance_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_id": headId,
    "conveyance_id": conveyanceId,
  };
}

class AddInstrumentForPlanning {
  String? id;
  String? headId;
  String? instrumentId;

  AddInstrumentForPlanning({
    this.id,
    this.headId,
    this.instrumentId,
  });

  factory AddInstrumentForPlanning.fromJson(Map<String, dynamic> json) => AddInstrumentForPlanning(
    id: json["id"],
    headId: json["head_id"],
    instrumentId: json["instrument_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_id": headId,
    "instrument_id": instrumentId,
  };
}

class Note {
  String? id;
  String? title;

  Note({
    this.id,
    this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class Planning {
  String? id;
  String? location;
  List<System>? system;

  Planning({
    this.id,
    this.location,
    this.system,
  });

  factory Planning.fromJson(Map<String, dynamic> json) => Planning(
    id: json["id"],
    location: json["location"],
    system: json["system"] == null ? [] : List<System>.from(json["system"]!.map((x) => System.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location,
    "system": system == null ? [] : List<dynamic>.from(system!.map((x) => x.toJson())),
  };
}

class System {
  String? id;
  String? title;
  List<Service>? service;

  System({
    this.id,
    this.title,
    this.service,
  });

  factory System.fromJson(Map<String, dynamic> json) => System(
    id: json["id"],
    title: json["title"],
    service: json["service"] == null ? [] : List<Service>.from(json["service"]!.map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
  };
}

class Service {
  String? id;
  String? serviceId;

  Service({
    this.id,
    this.serviceId,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    serviceId: json["service_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_id": serviceId,
  };
}

class RemovedConveyance {
  String? removedConveyanceId;

  RemovedConveyance({
    this.removedConveyanceId,
  });

  factory RemovedConveyance.fromJson(Map<String, dynamic> json) => RemovedConveyance(
    removedConveyanceId: json["removed_conveyance_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_conveyance_id": removedConveyanceId,
  };
}

class RemovedInstrument {
  String? removedInstrumentId;

  RemovedInstrument({
    this.removedInstrumentId,
  });

  factory RemovedInstrument.fromJson(Map<String, dynamic> json) => RemovedInstrument(
    removedInstrumentId: json["removed_instrument_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_instrument_id": removedInstrumentId,
  };
}

class RemovedNote {
  String? removedNoteId;

  RemovedNote({
    this.removedNoteId,
  });

  factory RemovedNote.fromJson(Map<String, dynamic> json) => RemovedNote(
    removedNoteId: json["removed_note_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_note_id": removedNoteId,
  };
}

class RemovedPlanning {
  String? removedPlanningId;

  RemovedPlanning({
    this.removedPlanningId,
  });

  factory RemovedPlanning.fromJson(Map<String, dynamic> json) => RemovedPlanning(
    removedPlanningId: json["removed_planning_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_planning_id": removedPlanningId,
  };
}

class RemovedService {
  String? removedServiceId;

  RemovedService({
    this.removedServiceId,
  });

  factory RemovedService.fromJson(Map<String, dynamic> json) => RemovedService(
    removedServiceId: json["removed_service_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_service_id": removedServiceId,
  };
}

class RemovedSystem {
  String? removedSystemId;

  RemovedSystem({
    this.removedSystemId,
  });

  factory RemovedSystem.fromJson(Map<String, dynamic> json) => RemovedSystem(
    removedSystemId: json["removed_system_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_system_id": removedSystemId,
  };
}

class RemovedWorkman {
  String? removedWorkmanId;

  RemovedWorkman({
    this.removedWorkmanId,
  });

  factory RemovedWorkman.fromJson(Map<String, dynamic> json) => RemovedWorkman(
    removedWorkmanId: json["removed_workman_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_workman_id": removedWorkmanId,
  };
}

class AddWorkman {
  String? id;
  String? workmanId;

  AddWorkman({
    this.id,
    this.workmanId,
  });

  factory AddWorkman.fromJson(Map<String, dynamic> json) => AddWorkman(
    id: json["id"],
    workmanId: json["workman_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workman_id": workmanId,
  };
}
