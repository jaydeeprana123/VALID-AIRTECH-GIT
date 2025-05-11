// To parse this JSON data, do
//
//     final workmanListResponse = workmanListResponseFromJson(jsonString);

import 'dart:convert';

WorkmanListResponse workmanListResponseFromJson(String str) => WorkmanListResponse.fromJson(json.decode(str));

String workmanListResponseToJson(WorkmanListResponse data) => json.encode(data.toJson());

class WorkmanListResponse {
  bool? status;
  String? message;
  int? code;
  List<WorkmanData>? data;

  WorkmanListResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory WorkmanListResponse.fromJson(Map<String, dynamic> json) => WorkmanListResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<WorkmanData>.from(json["data"]!.map((x) => WorkmanData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WorkmanData {
  int? id;
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
  String? workmanNo;
  String? status;
  String? email;
  List<WorkmanChild>? children;
  List<String> overTimes = [];
  String? attendanceStatus;
  String? attendanceStatusId;
  bool isCheckedES = false;
  bool isCheckedPO = false;
  bool isCheckedPH = false;
  WorkmanData({
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
    this.workmanNo,
    this.status,
    this.email,
    this.children,
  });

  factory WorkmanData.fromJson(Map<String, dynamic> json) => WorkmanData(
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
    workmanNo: json["workman_no"],
    status: json["status"],
    email: json["email "],
    children: json["children"] == null ? [] : List<WorkmanChild>.from(json["children"]!.map((x) => WorkmanChild.fromJson(x))),
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
    "workman_no": workmanNo,
    "status": status,
    "email ": email,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}

class WorkmanChild {
  int? id;
  int? userId;
  String? childrenName;

  WorkmanChild({
    this.id,
    this.userId,
    this.childrenName,
  });

  factory WorkmanChild.fromJson(Map<String, dynamic> json) => WorkmanChild(
    id: json["id"],
    userId: json["user_id"],
    childrenName: json["children_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "children_name": childrenName,
  };
}
