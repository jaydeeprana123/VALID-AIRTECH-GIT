import 'package:flutter/material.dart';
import 'package:valid_airtech/Screens/Authentication/Model/change_password_request.dart';
import 'package:valid_airtech/Screens/Authentication/View/change_password_screen_view.dart';
import 'package:valid_airtech/Screens/Authentication/View/edit_profile_screen_view.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:get/get.dart';
import '../../../Styles/app_text_style.dart';
import '../Controller/login_controller.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());

    initialize();

  }

  initialize()async{
   await loginController.getLoginData();
  // loginController.callProfileDetailsAPI();
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
            'VALID',
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
        body:Obx(() => Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: color_primary,
              child: Center(
                child: Text(
                  "Profile",
                  style: AppTextStyle.largeRegular.copyWith(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            profileText(loginController.loginData.value.name??"", "Name"),
            profileText(loginController.loginData.value.userName??"", "User Name"),
            profileText(loginController.loginData.value.email??"", "Email"),
            profileText(loginController.loginData.value.mobileNumber??"", "Mobile Number"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileButton(Icons.edit, "Edit Profile", color_primary, true),
                const SizedBox(width: 10),
                profileButton(Icons.help_outline, "Change Password", color_primary, false),
              ],
            ),
            const Spacer(),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ""),
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget profileText(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.largeRegular.copyWith(fontSize: 18, color: color_primary),
        ),
        Text(
          label,
          style: AppTextStyle.largeRegular.copyWith(fontSize: 14, color: blackText),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget profileButton(IconData icon, String label, Color color, bool isEdit) {
    return ElevatedButton.icon(
      onPressed: () {

        if(isEdit){
          Get.to(EditProfileScreen());
        }else{
          Get.to(ChangePasswordScreen());
        }

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

