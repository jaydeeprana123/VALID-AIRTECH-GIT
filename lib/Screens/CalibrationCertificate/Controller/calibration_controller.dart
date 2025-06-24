import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Notes/Model/create_notes_request.dart';
import 'package:valid_airtech/Screens/Notes/Model/note_list_response.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/calibration_certificate_list_response.dart';

/// Controller
class CalibrationController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  RxBool isEdit = false.obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> fileNameController = TextEditingController().obs;

  RxList<CalibrationCertificateData> calibrationList =
      <CalibrationCertificateData>[].obs;
  Rx<CalibrationCertificateData> selectedCalibration =
      CalibrationCertificateData().obs;

  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;

  Rx<String> filePath = "".obs;

  Future getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();
  }

  /// Calibration list api call
  void callCalibrationList() async {
    try {
      isLoading.value = true;

      CalibrationCertificateListResponse response =
          await postRepository.calibrationList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        calibrationList.value = response.data ?? [];
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Calibration create api call
  Future<void> callCreateCalibration() async {
    try {
      isLoading.value = true;

      printData("callCreateCalibration ", "api called");

      BaseModel response = await postRepository.createCalibration(
          loginData.value.token ?? "",
          titleController.value.text,
          filePath.value,
          fileNameController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Calibration update api call
  Future<void> callUpdateCalibration(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.updateCalibration(
          loginData.value.token ?? "",
          id,
          titleController.value.text,
          filePath.value,
          fileNameController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Calibration delete api call
  Future<void> callDeleteCalibration(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.deleteCalibration(
          loginData.value.token ?? "", id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message ?? "");

        Get.snackbar("Success", "Circular deleted successfully");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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
    Get.delete<CalibrationController>();
  }
}
