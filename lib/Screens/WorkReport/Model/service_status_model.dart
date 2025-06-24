// To parse this JSON data, do
//
//     final testByPerformanceListResponse = testByPerformanceListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/test_by_perform_list_response.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';

import '../../Instruments/Model/isntrument_list_response.dart';
import '../../Sites/Model/employee_list_response.dart';

class ServiceStatusModel {
  String? dataSheetStatus;
  InstrumentData? usedInstrument;
  WorkmanData? workmanData;
  TestByPerformData? testPerformData;
  TextEditingController testLocationEditingController = TextEditingController(text: "");
  TextEditingController roomEquipmentEditingController = TextEditingController(text: "");
  TextEditingController remarkTextEditingController = TextEditingController(text: "");

  ServiceStatusModel({
    this.dataSheetStatus,
    this.usedInstrument,
    this.workmanData,
    this.testPerformData,
  });
}





