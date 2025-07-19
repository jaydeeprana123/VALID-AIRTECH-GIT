import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';

import 'package:valid_airtech/Screens/WorkmanProfile/Model/add_childern_model.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/View/edit_workman_screen.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/View/workman_details_screen.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/create_workman_request.dart';
import '../Model/workman_list_response.dart';
import '../View/add_workman_screen.dart';

/// Controller
class WorkmanProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  Rx<bool> isEdit = false.obs;

  Rx<CreateWorkmanRequest> createWorkmanRequest = CreateWorkmanRequest().obs;

  RxList<String> bloodGroups =
      ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"].obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> contactNoController = TextEditingController().obs;
  Rx<TextEditingController> workmanNoController = TextEditingController().obs;
  Rx<TextEditingController> workmanPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> permanentAddressController =
      TextEditingController().obs;
  Rx<TextEditingController> residentAddressController =
      TextEditingController().obs;
  Rx<TextEditingController> birthDateController = TextEditingController().obs;
  Rx<TextEditingController> aadharCardNoController =
      TextEditingController().obs;
  Rx<TextEditingController> startTimeController = TextEditingController().obs;

  Rx<TextEditingController> endTimeController = TextEditingController().obs;

  Rx<TextEditingController> licenseNoController = TextEditingController().obs;
  Rx<TextEditingController> epfNoController = TextEditingController().obs;
  Rx<TextEditingController> esiNoController = TextEditingController().obs;
  Rx<TextEditingController> bankNameController = TextEditingController().obs;
  Rx<TextEditingController> ifscCodeController = TextEditingController().obs;
  Rx<TextEditingController> accountNoController = TextEditingController().obs;
  Rx<TextEditingController> fatherNameController = TextEditingController().obs;
  Rx<TextEditingController> fatherAadharCardNoController =
      TextEditingController().obs;
  Rx<TextEditingController> motherNameController = TextEditingController().obs;
  Rx<TextEditingController> motherAadharCardNoController =
      TextEditingController().obs;
  Rx<TextEditingController> wifeNameController = TextEditingController().obs;
  Rx<TextEditingController> wifeAadharCardNoController =
      TextEditingController().obs;

  RxList<AddChildrenModel> childrenList = <AddChildrenModel>[].obs;
  RxList<RemovedWorkmanChild> removedChildrenList = <RemovedWorkmanChild>[].obs;

  RxList<WorkmanData> workmanList = <WorkmanData>[].obs;
  Rx<WorkmanData> selectedWorkman = WorkmanData().obs;
  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;

  Future<void> getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();
  }

  /// Instrument list api call
  void callWorkmanList() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response =
          await postRepository.workmanList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        workmanList.value = response.data ?? [];
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

  /// Workman Details api call
  void callWorkmanDetail() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response =
      await postRepository.workmanDetails(loginData.value.token ?? "",loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        workmanList.value = response.data ?? [];

        selectedWorkman.value = response.data?[0]??WorkmanData();

        Get.to(WorkmanDetailsScreen());

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


  /// Instrument list api call
  void callWorkmanListForAdmin() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response =
      await postRepository.workmanList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        workmanList.clear();
        workmanList.add(WorkmanData(id: 0, name: "All"));
        workmanList.addAll(response.data ?? []);
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


  /// Workman create api call
  Future<void> callCreateWorkman() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.createWorkman(
          loginData.value.token ?? "", createWorkmanRequest.value);
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

  /// Workman update api call
  Future<void> callUpdateWorkman() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.updateWorkman(
          loginData.value.token ?? "", createWorkmanRequest.value);
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

  /// Workman delete api call
  Future<void> callDeleteWorkman(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
          await postRepository.deleteWorkman(loginData.value.token ?? "", id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message ?? "");
        Get.snackbar("Success", "Workman deleted successfully");
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
    Get.delete<WorkmanProfileController>();
  }
}
