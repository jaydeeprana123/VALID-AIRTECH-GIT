import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../HeadConveyance/Model/head_conveyance_list_response.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/convey_model.dart';
import '../Model/create_instrument_request.dart';
import '../Model/head_instrument_list_response.dart';
import '../Model/instrument_model.dart';
import '../Model/isntrument_list_response.dart';


/// Controller
class InstrumentController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  Rx<CreateInstrumentRequest> createInstrumentRequest = CreateInstrumentRequest().obs;

  Rx<TextEditingController> instrumentIdNoController = TextEditingController().obs;
  Rx<TextEditingController> modelNoController = TextEditingController().obs;
  Rx<TextEditingController> srNoController = TextEditingController().obs;
  Rx<TextEditingController> makeController = TextEditingController().obs;

  RxList<TextEditingController> workmanList = <TextEditingController>[].obs;
  RxList<InstrumentData> instrumentList = <InstrumentData>[].obs;
  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;
  RxList<HeadInstrumentData> headInstrumentList = <HeadInstrumentData>[].obs;
  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }


  /// Head Instrument list api call
  void callHeadInstrumentList() async {
    try {
      isLoading.value = true;

      HeadInstrumentResponse response = await postRepository.headInstrumentList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        headInstrumentList.value = response.data??[];
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

  /// Instrument list api call
  void callInstrumentList() async {
    try {
      isLoading.value = true;

      InstrumentListResponse response = await postRepository.instrumentList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        instrumentList.value = response.data??[];
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


  /// Instrument create api call
  Future<void> callCreateInstrument() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createInstrument(loginData.value.token ?? "",createInstrumentRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
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
    Get.delete<InstrumentController>();
  }

}
