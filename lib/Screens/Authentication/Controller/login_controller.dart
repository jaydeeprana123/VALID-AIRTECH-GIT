import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/home_page.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../Model/login_request.dart';
import '../Model/login_response.dart';

/// Controller
class LoginController extends GetxController {
  /// Editing controller for text field
  Rx<String> imagePathOfProfile = "".obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> passwordController = TextEditingController().obs;

  Rx<TextEditingController> newPasswordController = TextEditingController().obs;

  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  Rx<TextEditingController> pinController = TextEditingController().obs;

  String? fcmToken = "ittuiioybibt89 ";

  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  String? deviceToken;
  Rx<TextEditingController> otpText = TextEditingController().obs;

  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    callProfileDetailsAPI();

  }

  /// Login api call
  void callLoginAPI() async {
    try {
      isLoading.value = true;

      LoginRequest loginRequest = LoginRequest();
      loginRequest.userName = userNameController.value.text;
      loginRequest.password = passwordController.value.text;
      loginRequest.deviceId = fcmToken ?? "TOcYmaP0okd5D6yQ";
      loginRequest.deviceType = "0";
      LoginResponse response = await postRepository.login(loginRequest);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        // Successful login

        Get.snackbar('Success', response.message ?? "");
        await MySharedPref().setLoginModel(
            response.data ?? LoginData(), SharePreData.keySaveLoginModel);

        Get.offAll(HomePage());
      } else {
        errorMessage.value = response.message ?? 'Unknown error';
        Get.snackbar('Error', errorMessage.value);
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

  /// Profile Details api call
  void callProfileDetailsAPI() async {
    try {
      isLoading.value = true;

      LoginResponse response = await postRepository.profile(loginData.value.eEmployeeToken??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status == 1) {
        loginData.value = response.data??LoginData();

        userNameController.value.text = loginData.value.eUserName??"";
        fullNameController.value.text = loginData.value.eEmployeeName??"";
        mobileController.value.text = loginData.value.eMobile??"";
        emailController.value.text = loginData.value.eEmail??"";
      } else {
        errorMessage.value = response.message ?? 'Unknown error';
        Get.snackbar('Error', errorMessage.value);
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
    Get.delete<LoginController>();
  }
}
