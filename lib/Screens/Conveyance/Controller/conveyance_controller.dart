import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Conveyance/Model/admin_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/update_conveyance_request.dart';
import 'package:intl/intl.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/head_conveyance_list_response.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/convey_model.dart';
import '../Model/create_conveyance_request.dart';
import '../Model/instrument_model.dart';


/// Controller
class ConveyanceController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;
  Rx<CreateConveyanceRequest> createConveyanceRequest = CreateConveyanceRequest().obs;
  Rx<UpdateConveyanceRequest> updateConveyanceRequest = UpdateConveyanceRequest().obs;

  Rx<TextEditingController> conveyanceTypeController = TextEditingController().obs;

  Rx<TextEditingController> conveyorNameController = TextEditingController().obs;
  Rx<TextEditingController> suffixController = TextEditingController().obs;
  Rx<TextEditingController> conveyorAddressController = TextEditingController().obs;


  RxList<TextEditingController> workmanList = <TextEditingController>[].obs;
  RxList<ConveyanceData> conveysList = <ConveyanceData>[].obs;
  APIRepository postRepository = APIRepository();
  Rx<ConveyanceData> selectedConveyance = ConveyanceData().obs;

  Rx<LoginData> loginData = LoginData().obs;
  RxList<AdminConveyanceData> adminConveyanceList = <AdminConveyanceData>[].obs;

  RxList<HeadConveyanceData> headConveysList = <HeadConveyanceData>[].obs;
  Rx<HeadConveyanceData> selectedHeadConveyance = HeadConveyanceData().obs;
  RxList<AddContactModel> contactList = <AddContactModel>[].obs;
  RxList<RemovedUpdateContact> removedContact = <RemovedUpdateContact>[].obs;
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;
  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
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


  /// Admin Expense list api call
  void callAdminConveyanceList(String empId) async {
    try {
      isLoading.value = true;

      AdminConveyanceListResponse response = await postRepository.adminConveyanceList(loginData.value.token??"", "0", empId, fromDateEditingController.value.text, toDateEditingController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        adminConveyanceList.value = response.data??[];
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

  /// Head Conveyance list api call
  void callHeadConveyanceList() async {
    try {
      isLoading.value = true;

      HeadConveyanceListResponse response = await postRepository.headConveyanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        headConveysList.value = response.data??[];
      } else {

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

  /// Conveyance list api call
  void callConveyanceList() async {
    try {
      isLoading.value = true;

      ConveyanceListResponse response = await postRepository.conveyanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        conveysList.value = response.data??[];
      } else {

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


  /// Conveyance create api call
  Future<void> callCreateConveyance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createConveyance(loginData.value.token ?? "",createConveyanceRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", "Conveyance created successfully");
        printData("response", response.message??"");

        contactList.clear();

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

  /// Conveyance edit api call
  Future<void> callEditConveyance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateConveyance(loginData.value.token ?? "",updateConveyanceRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", "Conveyance Update successfully");
        printData("response", response.message??"");

        contactList.clear();

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

  /// Conveyance delete api call
  Future<void> callDeleteConveyance(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteConveyance(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        contactList.clear();
        Get.snackbar("Success", "Conveyance deleted successfully");
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

  /// Conveyance create api call
  Future<void> callCreateConveyanceHead() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createHeadConveyance(loginData.value.token ?? "",conveyanceTypeController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", "Conveyance Type created successfully");

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

  /// Conveyance update api call
  Future<void> callUpdateConveyanceHead() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateHeadConveyance(loginData.value.token ?? "",conveyanceTypeController.value.text, selectedHeadConveyance.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", "Conveyance Type updated successfully");

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

  /// Conveyance delete api call
  Future<void> callDeleteConveyanceHead(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteConveyanceHead(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        contactList.clear();
        Get.snackbar("Success", "Conveyance head deleted successfully");
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
    Get.delete<ConveyanceController>();
  }

}
