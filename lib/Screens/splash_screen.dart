import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/login_screen.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_icons.dart';
import '../utils/preference_utils.dart';
import '../utils/share_predata.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    redirectOnPendingState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body:
        // Center(
        //   child: GifImage(
        //     fit: BoxFit.cover,
        //     controller: controller,
        //       width: double.infinity,
        //       height: double.infinity,
        //
        //     image: const AssetImage(img_splash),
        //   ),
        // ),
        // Lottie.asset(
        //   img_splash,
        //   width: double.infinity,
        //   height: double.infinity,
        //   repeat: true,
        //   reverse: true,
        //   animate: true,
        // )

        Center(
          child: Image.asset(
            width: 200,
            iconLogo,
          ),
        ),

      ),
    );
  }

  void redirectOnPendingState() {
    Future.delayed(const Duration(seconds: 4), () async {

      Get.offAll(LoginScreen());

     //  LoginResponseModel? loginResponseModel =
     //  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel);
     //
     // var cartItemList =  await MySharedPref().getCartItems(SharePreData.keySaveCart);
     // if(cartItemList?.isForEditOrder??false){
     //   await MySharedPref().clearData(SharePreData.keySaveCart);
     // }
     //
     //  if (loginResponseModel != null && ((loginResponseModel.data?.user?.name??"0").isNotEmpty)) {
     //    Get.offAll(BottomNavigationView(selectTabPosition: 0));
     //  } else {
     //
     //     Get.off(() => WelcomeScreenView());
     //  }


    });
  }
}
