import 'package:flutter/material.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:get/get.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../Controller/login_controller.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = Get.find<LoginController>();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: color_secondary),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Valid Services",
            style: AppTextStyle.largeBold.copyWith(fontSize: 18, color: color_secondary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: color_secondary),
              onPressed: () {},
            ),
          ],
        ),
        body:Obx(() => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: color_primary,
                    child: Center(
                      child: Text(
                        "Change Password",
                        style: AppTextStyle.largeRegular.copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  profileText( "Old Password", loginController.passwordController.value),
                  profileText( "New Password", loginController.newPasswordController.value),
                  profileText( "Confirm Password", loginController.confirmPasswordController.value),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    margin: EdgeInsets.symmetric(vertical: 10)
                    ,child: CommonButton(
                    titleText: "Change Password",
                    textColor: Colors.white,
                    buttonColor: color_primary,
                    onCustomButtonPressed: () async {
                      if(loginController
                          .passwordController.value.text.isEmpty){
                        Get.snackbar("Error", "Enter Password");
                        return;
                      }

                      if(loginController
                          .newPasswordController.value.text.isEmpty){
                        Get.snackbar("Error", "Enter New Password");
                        return;
                      }

                      if(loginController
                          .confirmPasswordController.value.text.isEmpty){
                        Get.snackbar("Error", "Enter Confirm Password");
                        return;
                      }


                      if(loginController
                          .confirmPasswordController.value.text != loginController
                          .newPasswordController.value.text){
                        Get.snackbar("Error", "Password does not matched!");
                        return;
                      }


                      loginController.callChangePasswordAPI();

                    },
                    borderColor: color_primary,
                    borderWidth: 0,
                  ),
                  ),

                ],
              ),
            ),

            if(loginController.isLoading.value)Center(child: CircularProgressIndicator(),)
          ],
        )),
      ),
    );
  }

  Widget profileText(String hintName, TextEditingController textEditingController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
      
          TextField(
            controller: textEditingController
            ,decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            alignLabelWithHint: true,
            hintText: hintName,
            labelText: hintName,
            border: UnderlineInputBorder(),
            hintStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                , color: color_hint_text),
            labelStyle: AppTextStyle.largeRegular.copyWith(fontSize: 16
                , color: color_hint_text) ,
          ),
          ),

        ],
      ),
    );
  }

  Widget profileButton(IconData icon, String label, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        // Button action
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: AppTextStyle.largeRegular.copyWith(fontSize: 13, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

