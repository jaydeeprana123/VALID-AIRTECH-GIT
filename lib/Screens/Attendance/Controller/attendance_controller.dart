import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/attendance_list_response.dart';
import 'package:valid_airtech/Screens/Attendance/Model/create_attendance_in_request.dart';
import 'package:valid_airtech/Screens/Offices/Model/office_list_response.dart';


import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Sites/Model/site_list_response.dart';


/// Controller
class AttendanceController extends GetxController {
  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;
  Rx<LoginData> loginData = LoginData().obs;
  RxList<SiteData> siteList = <SiteData>[].obs;
  RxList<OfficeData> officeList = <OfficeData>[].obs;
  RxList<String> statusList = <String>[].obs;

  RxList<AttendanceData> attendanceList = <AttendanceData>[].obs;
  Rx<AttendanceData> selectedAttendance = AttendanceData().obs;
  RxList<AppointmentContactData> attendanceContactList = <AppointmentContactData>[].obs;

  Rx<CreateAttendanceInRequest> createAttendanceInRequest = CreateAttendanceInRequest().obs;
  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    statusList.clear();
    statusList.add("In");
    statusList.add("Out");

    printData("token", loginData.value.token??"");

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


  /// office list api call
  Future callOfficeList() async {

    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      OfficeListResponse response = await postRepository.officeList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        officeList.value = response.data??[];
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


  /// site Emp list api call
  Future<void> callEmpSiteList() async {

    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      SiteListResponse response = await postRepository.empSiteList(loginData.value.token??"",loginData.value.id.toString());
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


  /// office list api call
  Future<void> callEmpOfficeList() async {

    printData("callEmpOfficeList", "callEmpOfficeList");
    try {
      isLoading.value = true;

      OfficeListResponse response = await postRepository.empOfficeList(loginData.value.token??"",loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        officeList.value = response.data??[];
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



  /// Attendance list api call
  void callAttendanceList() async {
    try {
      isLoading.value = true;

      AttendanceListResponse response = await postRepository.attendanceList(loginData.value.token??"",loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        attendanceList.value = response.data??[];
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


  /// Attendance list api call
  void callAttendanceListByDate(String date) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response = await postRepository.attendanceListByDate(loginData.value.token??"",loginData.value.id.toString(), date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        attendanceList.value = response.data??[];
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


  /// Attendance create api call
  Future<void> callCreateAttendanceIn() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createAttendanceIn(loginData.value.token ?? "",createAttendanceInRequest.value);
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


  /// Attendance out api call
  Future<void> callCreateAttendanceOut() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createAttendanceOut(loginData.value.token ?? "",createAttendanceInRequest.value);
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<AttendanceController>();
  }

  ///Clear all field
  clearAllField() {

  }
}
