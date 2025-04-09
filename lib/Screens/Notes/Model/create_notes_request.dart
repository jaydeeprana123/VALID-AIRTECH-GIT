// To parse this JSON data, do
//
//     final createNotesRequest = createNotesRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

CreateNotesRequest createNotesRequestFromJson(String str) => CreateNotesRequest.fromJson(json.decode(str));

String createNotesRequestToJson(CreateNotesRequest data) => json.encode(data.toJson());

class CreateNotesRequest {
  String? empId;
  String? id;
  String? date;
  List<NoteNameData>? note;
  List<RemovedNote>? removedNote;

  CreateNotesRequest({
    this.empId,
    this.id,
    this.date,
    this.note,
    this.removedNote,
  });

  factory CreateNotesRequest.fromJson(Map<String, dynamic> json) => CreateNotesRequest(
    empId: json["emp_id"],
    id: json["id"],
    date: json["date"],
    note: json["note"] == null ? [] : List<NoteNameData>.from(json["note"]!.map((x) => NoteNameData.fromJson(x))),
    removedNote: json["removed_note"] == null ? [] : List<RemovedNote>.from(json["removed_note"]!.map((x) => RemovedNote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "emp_id":empId,
    "id": id,
    "date": date,
    "note": note == null ? [] : List<dynamic>.from(note!.map((x) => x.toJson())),
    "removed_note": removedNote == null ? [] : List<dynamic>.from(removedNote!.map((x) => x.toJson())),
  };
}

class NoteNameData {
  String? id;
  String? name;
  TextEditingController textEditingController = TextEditingController();

  NoteNameData({
    this.id,
    this.name,
  });

  factory NoteNameData.fromJson(Map<String, dynamic> json) => NoteNameData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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
