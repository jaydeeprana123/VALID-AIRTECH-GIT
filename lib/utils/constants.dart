import 'package:flutter/cupertino.dart';

class Constants {
  static bool islargeScreen = false;
  static const navigationRailKey = ValueKey('navigationRailKey');


  static const prefLoginData = 'loginData';

  //route key
  static const splashKey = "/splash";
  static const workThroughKey = "/workThrough";
  static const bottomNavigationKey = '/bottomNavigation';
  static const homeKey = '/home';
  static const loginKey = "/login";
  static const forgotPasswordKey = "/forgotPassword";
  static const verifyEmailKey = "/verifyEmail";
  static const newPasswordKey = "/newPassword";
  static const reviewListKey = "/reviewList";
  static const newOrderKey = "/newOrder";
  static const clientDetailsKey = "/clientDetails";
  static const doorsHingesKey = "/doorsHinges";
  static const doorsAndScreenKey = "/doorsAndScreen";
  static const doorsTabKey = "/doorsTab";
  static const orderSummaryKey = "/orderSummary";
  static const userListKey = "/userList";
  static const addUserKey = "/addUser";
  static Future<bool> validEmail(String email)async{
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }


}
