import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Service/View/add_service_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../Model/create_service_request.dart';
import '../Model/emp_leave_request_list_response.dart';


/// Controller
class EmpLeaveRequestController extends GetxController {
  APIRepository postRepository = APIRepository();
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  Rx<CreateServiceRequest> createServiceRequest = CreateServiceRequest().obs;

  RxList<EmpLeaveRequestData> empLeaveRequestList = <EmpLeaveRequestData>[].obs;

  final Rx<TextEditingController> controllerTestName = TextEditingController(text: "")
      .obs;

  final Rx<TextEditingController> controllerTestCode = TextEditingController(text:"")
      .obs;

  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }


  /// Employee Leaver request list api call
  void callEmployeeLeaveRequestList(String empId) async {
    try {
      isLoading.value = true;

      EmpLeaveRequestListResponse response = await postRepository.employeeLeaveRequestList(loginData.value.token??"", empId);
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

  /// Service create api call
  // Future<void> callCreateService() async {
  //   try {
  //     isLoading.value = true;
  //
  //     printData("site ", "api called");
  //
  //     BaseModel response =
  //     await postRepository.createService(loginData.value.token ?? "",createServiceRequest.value);
  //     isLoading.value = false;
  //
  //     // Get.snackbar("response ",loginResponseToJson(response));
  //
  //     if (response.status ?? false) {
  //       Get.snackbar("Success", response.message??"");
  //       printData("response", response.message??"");
  //       Get.off(AddServiceScreen());
  //
  //     } else if (response.code == 401) {
  //       Helper().logout();
  //     }else {
  //       Get.snackbar("Error", response.message ?? "Something went wrong");
  //     }
  //   } catch (ex) {
  //     if (ex is DioException) {
  //       errorMessage.value = ex.type.toString();
  //     } else {
  //       errorMessage.value = ex.toString();
  //     }
  //     Get.snackbar('Error', errorMessage.value);
  //   }
  // }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<EmpLeaveRequestController>();
  }

}
