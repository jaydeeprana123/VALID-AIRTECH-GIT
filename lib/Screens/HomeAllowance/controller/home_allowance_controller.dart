import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Allowance/Model/allowance_list_response.dart';
import '../../Authentication/Model/login_response.dart';
import '../../WorkmanProfile/Model/workman_list_response.dart';
import '../model/create_home_allowance_request.dart';
import '../model/home_allowance_list_response.dart';


/// Controller
class HomeAllowanceController extends GetxController {
  APIRepository postRepository = APIRepository();
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString selectedWorkman = "0".obs;
  var selectedStatus = "Select Status".obs;
  Rx<CreateHomeAllowanceRequest> createHomeAllowanceRequest = CreateHomeAllowanceRequest().obs;
  RxList<AllowanceData> allowanceList = <AllowanceData>[].obs;
  Rx<HomeAllowanceData> selectedHomeAllowance = HomeAllowanceData().obs;
  RxList<HomeAllowanceData> homeAllowanceList = <HomeAllowanceData>[].obs;
  RxList<WorkmanData> workmanList = <WorkmanData>[].obs;
  RxBool isEdit = false.obs;
  List<String> monthYearOptions = ["All", "January 2024", "February 2024"];

  List<String> statusOptions = ["Select Status", "Approved", "Pending", "Rejected"];
  var selectedMonthYear = "All".obs;
  final Rx<TextEditingController> controllerAmount = TextEditingController(text: "0")
      .obs;
  RxBool isChecked = false.obs;
  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }


  /// Allowance list api call
  void callAllowanceList() async {
    try {
      isLoading.value = true;

      AllowanceListResponse response = await postRepository.allowanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        allowanceList.value = response.data??[];
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

  /// Workman list api call
  void callWorkmanList() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response = await postRepository.workmanList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        workmanList.value = (response.data??[]);
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

  ///Home Allowance list api call
  void callHomeAllowanceList() async {
    try {
      isLoading.value = true;

      HomeAllowanceListResponse response = await postRepository.homeAllowanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        homeAllowanceList.value = response.data??[];
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

  ///Home Allowance list api call by date
  void callHomeAllowanceListByDate(String date) async {
    try {
      isLoading.value = true;

      HomeAllowanceListResponse response = await postRepository.homeAllowanceListByDate(loginData.value.token??"", date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        homeAllowanceList.value = response.data??[];
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

  /// Home Allowance create api call
  Future<void> callCreateHomeAllowance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.createHomeAllowance(
          loginData.value.token ?? "", createHomeAllowanceRequest.value);
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

  /// Home Allowance update api call
  Future<void> callUpdateHomeAllowance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.updateHomeAllowance(
          loginData.value.token ?? "", createHomeAllowanceRequest.value);
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

  /// Home Allowance delete api call
  Future<void> callDeleteHomeAllowance(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteHomeAllowance(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Instrument deleted successfully");
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
    Get.delete<HomeAllowanceController>();
  }

}
