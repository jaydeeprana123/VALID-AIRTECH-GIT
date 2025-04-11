import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Authentication/View/login_screen_view.dart';
import 'package:valid_airtech/Screens/emp_home_page.dart';
import 'package:valid_airtech/Screens/home_page.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../Model/change_password_request.dart';
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

  String? filePath;

  String? deviceToken;
  Rx<TextEditingController> otpText = TextEditingController().obs;

  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();

    // callProfileDetailsAPI();

  }

  /// Login api call
  void callLoginAPI() async {
    try {
      isLoading.value = true;

      LoginRequest loginRequest = LoginRequest();
      loginRequest.userName = userNameController.value.text;
      loginRequest.passCode = passwordController.value.text;
      // loginRequest.deviceId = fcmToken ?? "TOcYmaP0okd5D6yQ";
      // loginRequest.deviceType = "0";
      LoginResponse response = await postRepository.login(loginRequest);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        // Successful login

        Get.snackbar('Success', response.message ?? "");

        var loginData = response.data?[0] ?? LoginData();
        loginData.token = response.token??"";
        await MySharedPref().setLoginModel(
            loginData, SharePreData.keySaveLoginModel);

        if(loginData.roleId == 1){
          Get.offAll(HomePage());
        }else{
          Get.offAll(EmpHomePage());
        }


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

      LoginResponse response = await postRepository.profile(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        loginData.value = response.data?[0]??LoginData();

        userNameController.value.text = loginData.value.userName??"";
        fullNameController.value.text = loginData.value.name??"";
        mobileController.value.text = loginData.value.mobileNumber??"";
        emailController.value.text = loginData.value.email??"";
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

  /// Edit Profile api call
  void callEditProfileAPI() async {
    try {
      isLoading.value = true;

      LoginData loginDataRequest = LoginData();
      loginDataRequest.id = loginData.value.id;
      loginDataRequest.userName = userNameController.value.text;
      loginDataRequest.name = fullNameController.value.text;
      loginDataRequest.email = emailController.value.text;
      loginDataRequest.mobileNumber = mobileController.value.text;
      LoginResponse response = await postRepository.editProfile(loginDataRequest,filePath, loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        // Successful login

        Get.snackbar('Success', response.message ?? "");
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


  /// Change Password api call
  void callChangePasswordAPI() async {
    try {
      isLoading.value = true;

      ChangePasswordRequest changePasswordRequest = ChangePasswordRequest();
      changePasswordRequest.currentPassword = passwordController.value.text;
      changePasswordRequest.newPassword = newPasswordController.value.text;
      changePasswordRequest.newPasswordConfirmation = confirmPasswordController.value.text;
      // loginRequest.deviceId = fcmToken ?? "TOcYmaP0okd5D6yQ";
      // loginRequest.deviceType = "0";
      BaseModel response = await postRepository.changePassword(changePasswordRequest, loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        // Successful login

        Get.snackbar('Success', response.message ?? "");

        MySharedPref().clearData(SharePreData.keySaveLoginModel);
        Get.offAll(LoginScreenView());
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
