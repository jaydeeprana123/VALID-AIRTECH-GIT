import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';

import '../../../Widget/common_widget.dart';
import '../../../utils/constants.dart';


/// Controller
class AppointmentController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  final Rx<TextEditingController> controllerTrain = TextEditingController(text: "0")
      .obs;

  final Rx<TextEditingController> controllerBus = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerAuto = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerFuel = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerFoodAmount = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerOther = TextEditingController()
      .obs;

  final Rx<TextEditingController> controllerRemarksForOther = TextEditingController()
      .obs;

  final Rx<TextEditingController> controllerUsername = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerCity = TextEditingController().obs;
  final Rx<
      TextEditingController> controllerPhoneNumber = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerEmailId = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerPassword = TextEditingController()
      .obs;



  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<AppointmentController>();
  }

  ///Clear all field
  clearAllField() {
    controllerUsername.value.clear();
    controllerCity.value.clear();
    controllerPhoneNumber.value.clear();
    controllerEmailId.value.clear();
    controllerPassword.value.clear();
  }
}
