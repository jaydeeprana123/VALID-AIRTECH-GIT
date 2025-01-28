import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_icons.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/CommonProgressDialog.dart';
import '../../../Widget/CustomTextFiled.dart';
import '../../../utils/constants.dart';
import '../Controller/login_controller.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenView> {
  bool _isObscure = true;

  bool isDataFill = false;
  final _formKey = GlobalKey<FormState>();

  /// Initialize the controller
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    // Listen for changes in the TextField
    loginController.passwordController.value.addListener(() {
      setState(() {
        // Check if the length of the input is 10 digits
        isDataFill = loginController.passwordController.value.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: bottomBgColor, // navigation bar color
        // status bar icons' color
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Obx(() => Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Logo Section
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        iconLogo, // Replace with your logo path
                                        height: 120,
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 40),

                                // Input Fields Section
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Column(
                                    children: [
                                      // Username Field
                                      TextField(
                                        controller: loginController.userNameController.value
                                        ,decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 0),
                                          alignLabelWithHint: true,
                                          hintText: 'Username',
                                          labelText: "Username",
                                          border: UnderlineInputBorder(),
                                          hintStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                                              , color: color_hint_text),
                                          labelStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                                              , color: color_hint_text) ,
                                        ),
                                      ),
                                      SizedBox(height: 20),

                                      // Password Field
                                      TextField(
                                        controller: loginController.passwordController.value,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 0),
                                          alignLabelWithHint: true,
                                          hintText: 'Password',
                                          labelText: "Password",
                                          border: UnderlineInputBorder(),
                                          hintStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                                              , color: color_hint_text) ,
                                          labelStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                                              , color: color_hint_text) ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.w),
                          margin: EdgeInsets.symmetric(vertical: 20)
                          ,child: CommonButton(
                            titleText: "Log in",
                            textColor: isDataFill == true
                                ? Colors.white
                                : disableTextColor,
                            buttonColor: isDataFill == true
                                ? color_primary
                                : btnDisableBgColor,
                            onCustomButtonPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {

                                if(loginController
                                    .userNameController.value.text.isEmpty){
                                  Get.snackbar("Error", "Enter Username");
                                  return;
                                }

                                if (loginController
                                    .passwordController.value.text.length <
                                    6) {
                                  Get.snackbar(
                                      "Error", "Password must be 6 letters");
                                  return;
                                }

                                loginController.callLoginAPI();
                              }
                            },
                            borderColor: color_primary,
                            borderWidth: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (loginController.isLoading.value) CommonProgressDialog(),
                ],
              )),
        ),
      ),
    );
  }
}
