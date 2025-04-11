// To parse this JSON data, do
//
//     final addLeaveRequest = addLeaveRequestFromJson(jsonString);

import 'dart:convert';

AddLeaveRequest addLeaveRequestFromJson(String str) => AddLeaveRequest.fromJson(json.decode(str));

String addLeaveRequestToJson(AddLeaveRequest data) => json.encode(data.toJson());

class AddLeaveRequest {
  String? id;
  String? empId;
  String? leaveRequestType;
  String? fromDate;
  String? toDate;
  String? numberOfLeaveDays;
  String? reason;

  AddLeaveRequest({
    this.id,
    this.empId,
    this.leaveRequestType,
    this.fromDate,
    this.toDate,
    this.numberOfLeaveDays,
    this.reason,
  });

  factory AddLeaveRequest.fromJson(Map<String, dynamic> json) => AddLeaveRequest(
    id: json["id"],
    empId: json["emp_id"],
    leaveRequestType: json["leave_request_type"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    numberOfLeaveDays: json["number_of_leave_days"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "leave_request_type": leaveRequestType,
    "from_date": fromDate,
    "to_date": toDate,
    "number_of_leave_days": numberOfLeaveDays,
    "reason": reason,
  };
}
