import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/home_page.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../Model/employee_list_response.dart';
import '../Model/transportation_list_response.dart';


/// Controller
class SiteController extends GetxController {
  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;

  RxList<SiteData> siteList = <SiteData>[].obs;
  RxList<EmployeeData> employeeList = <EmployeeData>[].obs;
  RxList<TransportationData> transportationList = <TransportationData>[].obs;

  /// site list api call
  void callSiteList() async {
    try {
      isLoading.value = true;

      SiteListResponse response = await postRepository.siteList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        siteList.value = response.data??[];
      } else {

      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }


  /// Employee list api call
  void callEmployeeList() async {
    try {
      isLoading.value = true;

      EmployeeListResponse response = await postRepository.employeeList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        employeeList.value = response.data??[];
      } else {

      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Transportation list api call
  void callTransportationList() async {
    try {
      isLoading.value = true;

      TransportationListResponse response = await postRepository.transportationList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        transportationList.value = response.data??[];
      } else {

      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<SiteController>();
  }
}
