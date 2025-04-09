// To parse this JSON data, do
//
//     final noteListResponse = noteListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

NoteListResponse noteListResponseFromJson(String str) => NoteListResponse.fromJson(json.decode(str));

String noteListResponseToJson(NoteListResponse data) => json.encode(data.toJson());

class NoteListResponse {
  bool? status;
  String? message;
  int? code;
  List<NoteData>? data;

  NoteListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory NoteListResponse.fromJson(Map<String, dynamic> json) => NoteListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<NoteData>.from(json["data"]!.map((x) => NoteData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NoteData {
  int? id;
  String? date;
  List<Notes>? note;

  NoteData({
    this.id,
    this.date,
    this.note,
  });

  factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
    id: json["id"],
    date: json["date"],
    note: json["note"] == null ? [] : List<Notes>.from(json["note"]!.map((x) => Notes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "note": note == null ? [] : List<dynamic>.from(note!.map((x) => x.toJson())),
  };
}

class Notes {
  int? id;
  int? noteId;
  String? name;

  Notes({
    this.id,
    this.noteId,
    this.name,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    id: json["id"],
    noteId: json["note_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note_id": noteId,
    "name": name,
  };
}
