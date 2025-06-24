import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Service/View/add_service_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/test_by_perform_list_response.dart';


import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/create_test_perform_request.dart';
import '../Model/service_list_response.dart';


/// Controller
class TestPerformController extends GetxController {
  APIRepository postRepository = APIRepository();
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  Rx<bool> isEdit = false.obs;
  Rx<CreateTestPerformRequest> createTestPerformRequest = CreateTestPerformRequest().obs;

  RxList<TestByPerformData> testPerformList = <TestByPerformData>[].obs;
  Rx<TestByPerformData> selectedTestPerform = TestByPerformData().obs;
  final Rx<TextEditingController> controllerTestName = TextEditingController(text: "")
      .obs;


  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }


  /// TestPerform list api call
  void callTestPerformListList() async {
    try {
      isLoading.value = true;

      TestByPerformanceListResponse response = await postRepository.adminTestPerformList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        testPerformList.value = response.data??[];
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

  /// TestPerform create api call
  Future<void> callCreateTestPerform() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createTestPerform(loginData.value.token ?? "",createTestPerformRequest.value);
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

  /// Service update api call
  Future<void> callUpdateTestPerform() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateTestPerform(loginData.value.token ?? "",createTestPerformRequest.value);
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

  /// test delete api call
  Future<void> callDeleteTestPerform(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteService(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");
        Get.snackbar("Success", "Service deleted successfully");
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
    Get.delete<TestPerformController>();
  }

}
