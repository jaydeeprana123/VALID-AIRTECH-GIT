import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Head/Model/create_head_request.dart';
import 'package:valid_airtech/Screens/Offices/Model/create_office_request.dart';
import 'package:valid_airtech/Screens/Offices/Model/office_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/driver_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/home_page.dart';
import 'package:valid_airtech/base_model.dart';
import 'package:valid_airtech/utils/helper.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Head/Model/head_list_response.dart';
import '../Model/add_contact_model.dart';
import '../Model/create_site_request.dart';
import '../Model/employee_list_response.dart';
import '../Model/test_type_list_response.dart';
import '../Model/transportation_list_response.dart';

/// Controller
class OfficeController extends GetxController {
  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;

  Rx<CreateOfficeRequest> createOfficeRequest = CreateOfficeRequest().obs;

  RxBool isEdit = false.obs;

  Rx<OfficeData> selectedOffice = OfficeData().obs;
  RxList<OfficeData> officeList = <OfficeData>[].obs;
  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();
  }

  /// Office list api call
  void callOfficeList() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      OfficeListResponse response =
          await postRepository.officeList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        officeList.value = response.data ?? [];
      } else if (response.code == 401) {
        Helper().logout();
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


  /// site create api call
  Future<void> callCreateOffice() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createOffice(loginData.value.token ?? "",createOfficeRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Office created successfully");
        Get.back();
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
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

  /// site delete api call
  Future<void> callDeleteOffice(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteOffice(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");
        Get.snackbar("Success", "Office deleted successfully");
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
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


  /// Office Edit api call
  Future<void> callEditOffice() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateOffice(loginData.value.token ?? "",createOfficeRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");
        Get.snackbar("Success", "Office updated successfully");
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
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
    Get.delete<OfficeController>();
  }
}
