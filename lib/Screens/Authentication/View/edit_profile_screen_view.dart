import 'package:flutter/material.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:get/get.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../Controller/login_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
        body:Obx(() => SingleChildScrollView(
          child: Column(
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
              InkWell(
                onTap: ()async{
                  loginController.imagePathOfProfile.value = await selectPhoto(context);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: (loginController
                            .imagePathOfProfile.value.isNotEmpty)
                            ? Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ):const Icon(Icons.person, size: 50, color: Colors.grey),
                      ),
          
                      Container(child: Align(alignment: Alignment.bottomRight,child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, color: color_primary, size: 20,),
                      )))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              profileText( "Name", loginController.fullNameController.value),
              profileText( "User Name", loginController.userNameController.value),
              profileText( "Mobile Number", loginController.mobileController.value),
              profileText( "Email", loginController.emailController.value),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10)
                ,child: CommonButton(
                titleText: "Save Profile",
                textColor: Colors.white,
                buttonColor: color_primary,
                onCustomButtonPressed: () async {
                  if(loginController
                      .userNameController.value.text.isEmpty){
                    Get.snackbar("Error", "Enter Username");
                    return;
                  }
          
                  if(loginController
                      .fullNameController.value.text.isEmpty){
                    Get.snackbar("Error", "Enter Full Name");
                    return;
                  }
          
                  if(loginController
                      .mobileController.value.text.isEmpty){
                    Get.snackbar("Error", "Enter Mobile Number");
                    return;
                  }
          
                    loginController.callLoginAPI();
          
                },
                borderColor: color_primary,
                borderWidth: 0,
              ),
              ),
                 
            ],
          ),
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

