// To parse this JSON data, do
//
//     final updateConveyanceRequest = updateConveyanceRequestFromJson(jsonString);

import 'dart:convert';

UpdateConveyanceRequest updateConveyanceRequestFromJson(String str) => UpdateConveyanceRequest.fromJson(json.decode(str));

String updateConveyanceRequestToJson(UpdateConveyanceRequest data) => json.encode(data.toJson());

class UpdateConveyanceRequest {
  String? id;
  String? headConveyanceId;
  String? name;
  String? sufix;
  String? address;
  List<UpdateContact>? contact;
  List<RemovedUpdateContact>? removedContact;

  UpdateConveyanceRequest({
    this.id,
    this.headConveyanceId,
    this.name,
    this.sufix,
    this.address,
    this.contact,
    this.removedContact,
  });

  factory UpdateConveyanceRequest.fromJson(Map<String, dynamic> json) => UpdateConveyanceRequest(
    id: json["id"],
    headConveyanceId: json["head_conveyance_id"],
    name: json["name"],
    sufix: json["sufix"],
    address: json["address"],
    contact: json["contact"] == null ? [] : List<UpdateContact>.from(json["contact"]!.map((x) => UpdateContact.fromJson(x))),
    removedContact: json["removed_contact"] == null ? [] : List<RemovedUpdateContact>.from(json["removed_contact"]!.map((x) => RemovedUpdateContact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_conveyance_id": headConveyanceId,
    "name": name,
    "sufix": sufix,
    "address": address,
    "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
    "removed_contact": removedContact == null ? [] : List<dynamic>.from(removedContact!.map((x) => x.toJson())),
  };
}

class UpdateContact {
  String? id;
  String? contactType;
  String? mobileNo;
  String? telephone;

  UpdateContact({
    this.id,
    this.contactType,
    this.mobileNo,
    this.telephone,
  });

  factory UpdateContact.fromJson(Map<String, dynamic> json) => UpdateContact(
    id: json["id"],
    contactType: json["contact_type"],
    mobileNo: json["mobile_no"],
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contact_type": contactType,
    "mobile_no": mobileNo,
    "telephone": telephone,
  };
}

class RemovedUpdateContact {
  String? removedContactId;

  RemovedUpdateContact({
    this.removedContactId,
  });

  factory RemovedUpdateContact.fromJson(Map<String, dynamic> json) => RemovedUpdateContact(
    removedContactId: json["removed_contact_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_contact_id": removedContactId,
  };
}
