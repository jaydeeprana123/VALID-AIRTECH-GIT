import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Allowance/Model/admin_expense_list_response.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:intl/intl.dart';
import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/allowance_list_response.dart';
import '../Model/create_allowance_request.dart';


/// Controller
class AllowanceController extends GetxController {
  APIRepository postRepository = APIRepository();
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  RxList<AllowanceData> allowanceList = <AllowanceData>[].obs;
  RxList<AdminExpenseData> adminExpenseList = <AdminExpenseData>[].obs;

  Rx<AllowanceData> selectedAllowance = AllowanceData().obs;
  RxBool isEdit = false.obs;
  final Rx<TextEditingController> controllerName = TextEditingController(text: "")
      .obs;
  RxBool isChecked = false.obs;
  Rx<CreateAllowanceRequest> createAllowanceRequest = CreateAllowanceRequest().obs;
  Rx<LoginData> loginData = LoginData().obs;

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
  void callAdminExpenseList(String empId) async {
    try {
      isLoading.value = true;

      AdminExpenseListResponse response = await postRepository.adminExpenseList(loginData.value.token??"", "0", empId, fromDateEditingController.value.text, toDateEditingController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      adminExpenseList.clear();
      if (response.status??false) {
        adminExpenseList.value = response.data??[];
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

  /// Allowance create api call
  Future<void> callCreateAllowance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createAllowance(loginData.value.token ?? "",createAllowanceRequest.value);
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


  /// Allowance update api call
  Future<void> callUpdateAllowance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateAllowance(loginData.value.token ?? "",createAllowanceRequest.value);
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

  /// Allowance delete api call
  Future<void> callDeleteAllowance(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteAllowance(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");
        Get.snackbar("Success", "Allowance deleted successfully");
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
    Get.delete<AllowanceController>();
  }

}
