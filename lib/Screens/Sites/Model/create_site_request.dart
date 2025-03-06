// To parse this JSON data, do
//
//     final createSiteRequest = createSiteRequestFromJson(jsonString);

import 'dart:convert';

CreateSiteRequest createSiteRequestFromJson(String str) => CreateSiteRequest.fromJson(json.decode(str));

String createSiteRequestToJson(CreateSiteRequest data) => json.encode(data.toJson());

class CreateSiteRequest {
  String? id;
  String? headId;
  String? headAddress;
  String? sufix;
  String? contactName;
  String? departmentName;
  String? email;
  List<Contact>? contact;
  List<RemovedContact>? removedContact;

  CreateSiteRequest({
    this.id,
    this.headId,
    this.headAddress,
    this.sufix,
    this.contactName,
    this.departmentName,
    this.email,
    this.contact,
    this.removedContact,
  });

  factory CreateSiteRequest.fromJson(Map<String, dynamic> json) => CreateSiteRequest(
    id: json["id"],
    headId: json["head_id"],
    headAddress: json["head_address"],
    sufix: json["sufix"],
    contactName: json["contact_name"],
    departmentName: json["department_name"],
    email: json["email"],
    contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromJson(x))),
    removedContact: json["removed_contact"] == null ? [] : List<RemovedContact>.from(json["removed_contact"]!.map((x) => RemovedContact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head_id": headId,
    "head_address": headAddress,
    "sufix": sufix,
    "contact_name": contactName,
    "department_name": departmentName,
    "email": email,
    "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
    "removed_contact": removedContact == null ? [] : List<dynamic>.from(removedContact!.map((x) => x.toJson())),
  };
}

class Contact {
  String? id;
  String? contactType;
  String? mobileNo;
  String? telephone;

  Contact({
    this.id,
    this.contactType,
    this.mobileNo,
    this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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
