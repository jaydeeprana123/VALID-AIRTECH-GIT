import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/WorkReport/Model/admin_work_report_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/service_by_nature_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/test_by_perform_list_response.dart';

import 'package:valid_airtech/Screens/WorkReport/Model/work_report_list_response.dart';
import 'package:intl/intl.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Sites/Model/site_list_response.dart';
import '../Model/site_by_service_list_response.dart';


/// Controller
class WorkReportController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  APIRepository postRepository = APIRepository();
  RxBool isEdit = false.obs;
  RxList<AdminWorkReportData> adminWorkReportList = <AdminWorkReportData>[].obs;
  RxList<SiteByServiceData> siteAttendByListList = <SiteByServiceData>[].obs;
  RxList<ServiceByNatureData> serviceByNatureList = <ServiceByNatureData>[].obs;
  RxList<TestByPerformData> testPerformerList = <TestByPerformData>[].obs;

  RxList<RemarkWorkReport> remarksList = <RemarkWorkReport>[].obs;
  RxList<SiteData> siteList = <SiteData>[].obs;

  RxList<String> removedRemarkIds = <String>[].obs;
  RxList<String> removedBillIds = <String>[].obs;
  RxList<WorkReportExpensesBill> billsList = <WorkReportExpensesBill>[].obs;
  RxList<WorkReportData> workReportList = <WorkReportData>[].obs;
  RxList<String> conveyThroughList = ["Bike", "Auto Rikshaw", "Car", "Bus", "Train", "Other"].obs;

  Rx<WorkReportData> selectedWorkReportData = WorkReportData().obs;

  final Rx<TextEditingController> controllerTrain =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerBus =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerAuto =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerFuel =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerFoodAmount =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerOther =
      TextEditingController(text: "0").obs;

  final Rx<TextEditingController> controllerRemarksForOther =
      TextEditingController().obs;

  final Rx<TextEditingController> controllerUsername =
      TextEditingController().obs;
  final Rx<TextEditingController> controllerCity = TextEditingController().obs;
  final Rx<TextEditingController> controllerPhoneNumber =
      TextEditingController().obs;
  final Rx<TextEditingController> controllerEmailId =
      TextEditingController().obs;
  final Rx<TextEditingController> controllerPassword =
      TextEditingController().obs;

  Rx<LoginData> loginData = LoginData().obs;
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;

  Future getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();

    printData("token", loginData.value.token ?? "");

    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String todayDate = formatter.format(now);

// Get the first day of the previous month
    DateTime oneMonthBefore = DateTime(
      now.month == 1 ? now.year - 1 : now.year,
      now.month == 1 ? 12 : now.month - 1,
      1,
    );

    String oneMonthBeforeDate = formatter.format(oneMonthBefore);

    fromDateEditingController.value.text = oneMonthBeforeDate;
    toDateEditingController.value.text = todayDate;
  }



  /// site list api call
  Future callSiteList() async {

    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      SiteListResponse response = await postRepository.siteList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        siteList.value = response.data??[];
      }else if(response.code == 401){
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


  /// Admin Work Report list api call
  void callAdminWorkReportList(String empId) async {
    try {
      isLoading.value = true;

      AdminWorkReportListResponse response =
          await postRepository.adminWorkReportList(
              loginData.value.token ?? "",
              "0",
              empId,
              fromDateEditingController.value.text,
              toDateEditingController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      adminWorkReportList.clear();
      if (response.status ?? false) {
        adminWorkReportList.value = response.data ?? [];
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

  /// Work report list api call
  Future<void> callWorkReportList(String attendanceId) async {
    printData("callWorkReportList", "callWorkReportList");
    try {
      isLoading.value = true;

      WorkReportListResponse response = await postRepository.workReportList(
          loginData.value.token ?? "", attendanceId);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        workReportList.value = response.data ?? [];
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

  /// Site attend by list api call

  Future<void> callSiteAttendByList() async {


    printData("callSiteAttendByList", "callSiteAttendByList");
    try {
      isLoading.value = true;


      SiteByServiceLIstResponse response = await postRepository.siteAttendByList(loginData.value.token??"");

      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        siteAttendByListList.value = response.data??[];
      }else if(response.code == 401){
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

  /// Service by nature  list api call
  Future<void> callServiceByNatureByList() async {

    printData("callSiteAttendByList", "callSiteAttendByList");
    try {
      isLoading.value = true;

      ServiceByNatureResponse response = await postRepository.serviceByNatureList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        serviceByNatureList.value = response.data??[];
      }else if(response.code == 401){
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

  /// Test Performer  list api call
  Future<void> callTestPerformerList() async {

    printData("callSiteAttendByList", "callSiteAttendByList");
    try {
      isLoading.value = true;

      TestByPerformanceListResponse response = await postRepository.testPerformerList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        testPerformerList.value = response.data??[];
      }else if(response.code == 401){
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

  /// Work report create api call
  Future<void> callCreateWorkReportList(
      String attendanceId, String siteId) async {
    printData("callWorkReportList", "callWorkReportList");

    try {
      isLoading.value = true;

      BaseModel response = await postRepository.createWorkReport(
          loginData.value.token ?? "",
          attendanceId,
          siteId,
          controllerTrain.value.text,
          controllerBus.value.text,
          controllerAuto.value.text,
          controllerFuel.value.text,
          controllerFoodAmount.value.text,
          controllerOther.value.text,
          controllerRemarksForOther.value.text,
          remarksList,
          billsList);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
        Get.snackbar("Error", response.message ?? "");
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

  /// Work report update api call
  Future<void> callUpdateWorkReportList(
      String attendanceId, String siteId) async {
    printData("callUpdateWorkReportList", "callUpdateWorkReportList");

    try {
      isLoading.value = true;

      BaseModel response = await postRepository.updateWorkReport(
          selectedWorkReportData.value.id.toString(),
          loginData.value.token ?? "",
          attendanceId,
          siteId,
          controllerTrain.value.text,
          controllerBus.value.text,
          controllerAuto.value.text,
          controllerFuel.value.text,
          controllerFoodAmount.value.text,
          controllerOther.value.text,
          controllerRemarksForOther.value.text,
          remarksList,
          billsList,
          removedRemarkIds,
          removedBillIds);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
        Get.snackbar("Error", response.message ?? "");
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

  /// Work report delete api call
  Future<void> callDeleteWorkReport(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
          await postRepository.deleteOffice(loginData.value.token ?? "", id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message ?? "");
        Get.snackbar("Success", "Office deleted successfully");
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
    Get.delete<WorkReportController>();
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
