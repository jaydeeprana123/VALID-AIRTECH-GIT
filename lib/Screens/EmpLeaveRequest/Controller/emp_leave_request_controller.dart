import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/EmpLeaveRequest/Model/add_leave_request.dart';
import 'package:valid_airtech/Screens/Service/View/add_service_screen.dart';


import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/emp_leave_request_list_response.dart';


/// Controller
class EmpLeaveRequestController extends GetxController {
  APIRepository postRepository = APIRepository();
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;

  RxList<EmpLeaveRequestData> empLeaveRequestList = <EmpLeaveRequestData>[].obs;
  Rx<EmpLeaveRequestData> selectedEmpLeaveRequest = EmpLeaveRequestData().obs;
  Rx<AddLeaveRequest> addLeaveRequest = AddLeaveRequest().obs;

  final Rx<TextEditingController> controllerNumOfLeaves = TextEditingController(text: "")
      .obs;

  final Rx<TextEditingController> controllerReason = TextEditingController(text:"")
      .obs;

  final Rx<TextEditingController> controllerNameOfEmp = TextEditingController(text:"")
      .obs;

  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    controllerNameOfEmp.value.text = loginData.value.name??"";


  }


  /// Employee Leaver request list api call
  void callEmployeeLeaveRequestList() async {
    try {
      isLoading.value = true;

      EmpLeaveRequestListResponse response = await postRepository.employeeLeaveRequestList(loginData.value.token??"", loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        empLeaveRequestList.value = response.data??[];
      } else if(response.code == 401){
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

  /// leave request create api call
  Future<void> callCreateService() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createEmpLeaveRequest(loginData.value.token ?? "",addLeaveRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message??"");
        printData("response", response.message??"");

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


  /// leave request update api call
  Future<void> callUpdateService() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateEmpLeaveRequest(loginData.value.token ?? "",addLeaveRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message??"");
        printData("response", response.message??"");

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

  /// Leave Request delete api call
  Future<void> callDeleteLeaveRequest(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteEmpLeaveRequest(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Leave Request deleted successfully");
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
    Get.delete<EmpLeaveRequestController>();
  }

}
