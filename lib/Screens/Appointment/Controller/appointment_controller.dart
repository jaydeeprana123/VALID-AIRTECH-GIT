import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';


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
class AppointmentController extends GetxController {
  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;
  Rx<LoginData> loginData = LoginData().obs;
  RxList<SiteData> siteList = <SiteData>[].obs;

  RxList<AppointmentData> appointmentList = <AppointmentData>[].obs;
  Rx<AppointmentData> selectedAppointment = AppointmentData().obs;
  RxList<AppointmentContactData> appointmentContactList = <AppointmentContactData>[].obs;

  Rx<CreateAppointmentRequest> createAppointmentRequest = CreateAppointmentRequest().obs;
  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    printData("token", loginData.value.token??"");

  }


  /// site list api call
  Future<void> callSiteList() async {

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

      printData("Error site", errorMessage.value);
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Contact list api call
  Future callContactListList(String headId) async {
    try {
      isLoading.value = true;

      AppointmentContactListResponse response = await postRepository.appointmentContactList(loginData.value.token??"", headId);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        appointmentContactList.value = response.data??[];
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

  /// Appointment list api call
  void callAppointmentList() async {
    try {
      isLoading.value = true;

      AppointmentListResponse response = await postRepository.appointmentList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      appointmentList.clear();
      if (response.status??false) {
        appointmentList.value = response.data??[];
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

  /// Appointment list by date api call
  void callAppointmentListByDate(String date) async {
    try {
      isLoading.value = true;

      AppointmentListResponse response = await postRepository.appointmentListByDate(loginData.value.token??"", date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      appointmentList.clear();
      if (response.status??false) {
        appointmentList.value = response.data??[];
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

  /// Appointment list by date api call
  void callAppointmentListByMonth(String date, String endDate) async {
    try {
      isLoading.value = true;

      AppointmentListResponse response = await postRepository.appointmentListByMonth(loginData.value.token??"", date, endDate);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      appointmentList.clear();
      if (response.status??false) {
        appointmentList.value = response.data??[];
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


  /// Appointment create api call
  Future<void> callCreateAppointment(BuildContext context) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createAppointment(loginData.value.token ?? "",createAppointmentRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        // Get.back();

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? "Success"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

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

  /// Appointment update api call
  Future<void> callUpdateAppointment() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateAppointment(loginData.value.token ?? "",createAppointmentRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message??"");
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

  /// Appointment delete api call
  Future<void> callDeleteAppointment(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteAppointment(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Appointment deleted successfully");
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
    Get.delete<AppointmentController>();
  }

  ///Clear all field
  clearAllField() {

  }
}
