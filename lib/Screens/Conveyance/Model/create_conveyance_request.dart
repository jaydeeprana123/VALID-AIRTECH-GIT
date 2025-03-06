// To parse this JSON data, do
//
//     final createConveyanceRequest = createConveyanceRequestFromJson(jsonString);

import 'dart:convert';

CreateConveyanceRequest createConveyanceRequestFromJson(String str) => CreateConveyanceRequest.fromJson(json.decode(str));

String createConveyanceRequestToJson(CreateConveyanceRequest data) => json.encode(data.toJson());

class CreateConveyanceRequest {
  String? id;
  String? headConveyanceId;
  String? name;
  String? sufix;
  String? address;
  List<ContactConveyance>? contact;
  List<RemovedContact>? removedContact;

  CreateConveyanceRequest({
    this.id,
    this.headConveyanceId,
    this.name,
    this.sufix,
    this.address,
    this.contact,
    this.removedContact,
  });

  factory CreateConveyanceRequest.fromJson(Map<String, dynamic> json) => CreateConveyanceRequest(
    id: json["id"],
    headConveyanceId: json["head_conveyance_id"],
    name: json["name"],
    sufix: json["sufix"],
    address: json["address"],
    contact: json["contact"] == null ? [] : List<ContactConveyance>.from(json["contact"]!.map((x) => ContactConveyance.fromJson(x))),
    removedContact: json["removed_contact"] == null ? [] : List<RemovedContact>.from(json["removed_contact"]!.map((x) => RemovedContact.fromJson(x))),
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

class ContactConveyance {
  String? id;
  String? contactType;
  String? mobileNo;
  String? telephone;

  ContactConveyance({
    this.id,
    this.contactType,
    this.mobileNo,
    this.telephone,
  });

  factory ContactConveyance.fromJson(Map<String, dynamic> json) => ContactConveyance(
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

class RemovedContact {
  String? removedContactId;

  RemovedContact({
    this.removedContactId,
  });

  factory RemovedContact.fromJson(Map<String, dynamic> json) => RemovedContact(
    removedContactId: json["removed_contact_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_contact_id": removedContactId,
  };
}
