import 'dart:developer';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valid_airtech/Screens/home_page.dart';
import 'package:valid_airtech/Styles/my_colors.dart';

import '../Styles/app_text_style.dart';
import '../Styles/my_icons.dart';
import '../Widget/CommonButton.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    decoration: InputDecoration(
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

            SizedBox(height: 20),

            // Login Button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              child: CommonButton(
                titleText: "Log in",
                textColor: Colors.white,
                onCustomButtonPressed: () async {

                  Get.to(HomePage());

                },
                borderColor: color_primary,
                borderWidth: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
