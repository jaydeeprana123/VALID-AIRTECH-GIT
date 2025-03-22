// To parse this JSON data, do
//
//     final createWorkmanRequest = createWorkmanRequestFromJson(jsonString);

import 'dart:convert';

CreateWorkmanRequest createWorkmanRequestFromJson(String str) => CreateWorkmanRequest.fromJson(json.decode(str));

String createWorkmanRequestToJson(CreateWorkmanRequest data) => json.encode(data.toJson());

class CreateWorkmanRequest {
  String? id;
  String? name;
  String? mobileNumber;
  String? permanetAddress;
  String? residentAddress;
  String? dateOfBirth;
  String? startTime;
  String? endTime;
  String? bloodGroup;
  String? addharNo;
  String? licenceNo;
  String? epfNo;
  String? esiNo;
  String? bankName;
  String? ifscCode;
  String? bankAccountNo;
  String? fatherName;
  String? fatherAddharNo;
  String? motherName;
  String? motherAddharNo;
  String? wifeName;
  String? wifeAddharNo;
  String? userName;
  String? password;
  String? workmanNo;
  String? status;
  String? email;
  List<Children>? children;
  List<RemovedChild>? removedChildren;

  CreateWorkmanRequest({
    this.id,
    this.name,
    this.mobileNumber,
    this.permanetAddress,
    this.residentAddress,
    this.dateOfBirth,
    this.startTime,
    this.endTime,
    this.bloodGroup,
    this.addharNo,
    this.licenceNo,
    this.epfNo,
    this.esiNo,
    this.bankName,
    this.ifscCode,
    this.bankAccountNo,
    this.fatherName,
    this.fatherAddharNo,
    this.motherName,
    this.motherAddharNo,
    this.wifeName,
    this.wifeAddharNo,
    this.userName,
    this.password,
    this.workmanNo,
    this.status,
    this.email,
    this.children,
    this.removedChildren,
  });

  factory CreateWorkmanRequest.fromJson(Map<String, dynamic> json) => CreateWorkmanRequest(
    id: json["id"],
    name: json["name"],
    mobileNumber: json["mobile_number"],
    permanetAddress: json["permanet_address"],
    residentAddress: json["resident_address"],
    dateOfBirth: json["date_of_birth"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    bloodGroup: json["blood_group"],
    addharNo: json["addhar_no"],
    licenceNo: json["licence_no"],
    epfNo: json["epf_no"],
    esiNo: json["esi_no"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    bankAccountNo: json["bank_account_no"],
    fatherName: json["father_name"],
    fatherAddharNo: json["father_addhar_no"],
    motherName: json["mother_name"],
    motherAddharNo: json["mother_addhar_no"],
    wifeName: json["wife_name"],
    wifeAddharNo: json["wife_addhar_no"],
    userName: json["user_name"],
    password: json["password"],
    workmanNo: json["workman_no"],
    status: json["status"],
    email: json["email"],
    children: json["children"] == null ? [] : List<Children>.from(json["children"]!.map((x) => Children.fromJson(x))),
    removedChildren: json["removed_children"] == null ? [] : List<RemovedChild>.from(json["removed_children"]!.map((x) => RemovedChild.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile_number": mobileNumber,
    "permanet_address": permanetAddress,
    "resident_address": residentAddress,
    "date_of_birth": dateOfBirth,
    "start_time": startTime,
    "end_time": endTime,
    "blood_group": bloodGroup,
    "addhar_no": addharNo,
    "licence_no": licenceNo,
    "epf_no": epfNo,
    "esi_no": esiNo,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "bank_account_no": bankAccountNo,
    "father_name": fatherName,
    "father_addhar_no": fatherAddharNo,
    "mother_name": motherName,
    "mother_addhar_no": motherAddharNo,
    "wife_name": wifeName,
    "wife_addhar_no": wifeAddharNo,
    "user_name": userName,
    "password": password,
    "workman_no": workmanNo,
    "status": status,
    "email": email,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "removed_children": removedChildren == null ? [] : List<dynamic>.from(removedChildren!.map((x) => x.toJson())),
  };
}

class Children {
  String? id;
  String? childrenName;

  Children({
    this.id,
    this.childrenName,
  });

  factory Children.fromJson(Map<String, dynamic> json) => Children(
    id: json["id"],
    childrenName: json["children_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "children_name": childrenName,
  };
}

class RemovedChild {
  String? removedChildrenId;

  RemovedChild({
    this.removedChildrenId,
  });

  factory RemovedChild.fromJson(Map<String, dynamic> json) => RemovedChild(
    removedChildrenId: json["removed_children_id"],
  );

  Map<String, dynamic> toJson() => {
    "removed_children_id": removedChildrenId,
  };
}
