import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
class SiteController extends GetxController {
  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;

  Rx<TextEditingController> siteAddressController = TextEditingController().obs;
  Rx<TextEditingController> suffixController = TextEditingController().obs;
  Rx<TextEditingController> contactNameController = TextEditingController().obs;
  Rx<TextEditingController> departmentNameController = TextEditingController().obs;
  Rx<TextEditingController> contactEmailController = TextEditingController().obs;

  RxList<AddContactModel> contactList = <AddContactModel>[].obs;

  RxList<SiteData> siteList = <SiteData>[].obs;
  RxList<EmployeeData> employeeList = <EmployeeData>[].obs;
  RxList<TransportationData> transportationList = <TransportationData>[].obs;
  RxList<TestTypeData> testTypeList = <TestTypeData>[].obs;
  RxList<DriverData> allDriverList = <DriverData>[].obs;
  RxList<DriverData> filteredDriverList = <DriverData>[].obs;
  RxList<HeadData> headList = <HeadData>[].obs;

  Rx<LoginData> loginData = LoginData().obs;

  Rx<CreateSiteRequest> createSiteRequest = CreateSiteRequest().obs;

  Future getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();
  }

  /// site list api call
  void callSiteList() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      SiteListResponse response =
          await postRepository.siteList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        siteList.value = response.data ?? [];
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
  Future<void> callCreateSite() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createSite(loginData.value.token ?? "",createSiteRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {

        printData("response", response.message??"");

        contactList.clear();
        Get.snackbar("Success", "Site created successfully");
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

  /// head list api call
  void callHeadListList() async {
    try {
      isLoading.value = true;

      HeadListResponse response =
          await postRepository.headListList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        headList.value = response.data ?? [];
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

  /// Employee list api call
  void callEmployeeList() async {
    try {
      isLoading.value = true;

      EmployeeListResponse response = await postRepository.employeeList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        employeeList.value = response.data ?? [];
      } else {}
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Transportation list api call
  void callTransportationList() async {
    try {
      isLoading.value = true;

      TransportationListResponse response =
          await postRepository.transportationList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        transportationList.value = response.data ?? [];
      } else {}
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// test type list api call
  void callTestTypeList() async {
    try {
      isLoading.value = true;

      TestTypeListResponse response = await postRepository.testTypeList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        testTypeList.value = response.data ?? [];
      } else {}
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// driver list api call
  void callDriverList() async {
    try {
      isLoading.value = true;

      DriverListResponse response = await postRepository.driverList();
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        allDriverList.value = response.data ?? [];
      } else {}
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Filter Drivers as per transportation
  getFilteredDriver(String transportationId) {
    filteredDriverList.clear();
    for (int i = 0; i < allDriverList.length; i++) {
      if (allDriverList[i].drTransportId == transportationId) {
        filteredDriverList.add(allDriverList[i]);
      }
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<SiteController>();
  }
}
