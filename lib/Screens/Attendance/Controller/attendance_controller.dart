import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/admin_attendance_list_response.dart';
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
import 'package:intl/intl.dart';

import '../../WorkmanProfile/Model/workman_list_response.dart';
import '../Model/admin_create_attendance_request.dart';
import '../Model/admin_update_attendance_request.dart';


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
  RxList<String> attendanceStatusList = <String>[].obs;
  Rx<AdminCreateAttendanceRequest> adminCreateAttendanceRequest = AdminCreateAttendanceRequest().obs;

  RxList<AdminAttendanceData> adminAttendanceList = <AdminAttendanceData>[].obs;
  RxList<WorkmanData> workmanList = <WorkmanData>[].obs;
  Rx<AdminAttendanceData> selectedAdminAttendanceData = AdminAttendanceData().obs;
  Rx<AdminUpdateAttendanceRequest> adminUpdateAttendanceRequest= AdminUpdateAttendanceRequest().obs;
  RxList<AttendanceData> attendanceList = <AttendanceData>[].obs;
  Rx<AttendanceData> selectedAttendance = AttendanceData().obs;
  RxList<AppointmentContactData> attendanceContactList = <AppointmentContactData>[].obs;
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;
  Rx<CreateAttendanceInRequest> createAttendanceInRequest = CreateAttendanceInRequest().obs;
  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    statusList.clear();
    statusList.add("In");
    statusList.add("Out");

    attendanceStatusList.clear();
    attendanceStatusList.add("P (Present)");
    attendanceStatusList.add("PA (Present Absent)");
    attendanceStatusList.add("O (Weekly Off)");
    attendanceStatusList.add("H (Holiday)");
    attendanceStatusList.add("A (Absent)");
    printData("token", loginData.value.token??"");

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


  /// Workman list api call
  void callWorkmanList() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response = await postRepository.workmanList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      workmanList.clear();
      if (response.status??false) {
        workmanList.value = response.data??[];

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

  /// Admin Attendance list api call
  void callAdminAttendanceList(String empId) async {
    try {
      isLoading.value = true;

      AdminAttendanceListResponse response = await postRepository.adminAttendanceList(loginData.value.token??"", "0", empId, fromDateEditingController.value.text, toDateEditingController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      adminAttendanceList.clear();
      if (response.status??false) {
        adminAttendanceList.value = response.data??[];
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

  /// Admin Attendance create api call
  Future<void> callAdminCreateAttendance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createAdminAttendance(loginData.value.token ?? "",adminCreateAttendanceRequest.value);
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

  /// Admin Attendance update api call
  Future<void> callAdminUpdateAttendance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateAdminAttendance(loginData.value.token ?? "",adminUpdateAttendanceRequest.value);
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
