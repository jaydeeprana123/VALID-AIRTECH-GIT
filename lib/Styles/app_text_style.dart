import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valid_airtech/Styles/constant.dart';


import 'my_colors.dart';


abstract class AppTextStyle {
  static final TextStyle _commonStyle = TextStyle(color: Colors.white, fontFamily: PublicSans_Medium);

  static TextStyle xxLargeRegular = _commonStyle.copyWith(fontSize: 28.sp, fontFamily: PublicSans_Regular, color: Colors.white);
  static TextStyle xxLargeMedium = _commonStyle.copyWith(fontSize: 28.sp, fontFamily: PublicSans_Medium, color: Colors.white);
  static TextStyle xxLargeBold = _commonStyle.copyWith(fontSize: 24.sp, fontFamily: PublicSans_Bold, color: Colors.white);
  static TextStyle xxLargeSemiBold = _commonStyle.copyWith(fontSize: 27.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle xLargeBold = _commonStyle.copyWith(fontSize: 20.sp, fontFamily: PublicSans_Bold, color: Colors.white);
  static TextStyle xLargeSemiBold = _commonStyle.copyWith(fontSize: 20.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle xLargeMedium =
      _commonStyle.copyWith(fontSize: 20.sp, fontFamily: PublicSans_Medium, color: Colors.white);
  static TextStyle xxxLargeMedium =
  _commonStyle.copyWith(fontSize: 34.sp, fontFamily: PublicSans_Medium, color: Colors.white);

  static TextStyle xLargeRegular =
      _commonStyle.copyWith(fontSize: 20.sp, fontFamily: PublicSans_Regular, color: Colors.white);

  static TextStyle largeRegular =
      _commonStyle.copyWith(fontSize: 18.sp, fontFamily: PublicSans_Regular, color: Colors.white);

  static TextStyle largeMedium =
      _commonStyle.copyWith(fontSize: 18.sp, fontFamily: PublicSans_Medium, color: Colors.white);

  static TextStyle largeSemiBold =
  _commonStyle.copyWith(fontSize: 18.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle largeBold = _commonStyle.copyWith(fontSize: 18.sp, fontFamily: PublicSans_Bold, color: Colors.white);

  static TextStyle mediumRegular =
      _commonStyle.copyWith(fontSize: 15.sp, fontFamily: PublicSans_Regular, color: Colors.white);

  static TextStyle mediumMedium =
      _commonStyle.copyWith(fontSize: 15.sp, fontFamily: PublicSans_Medium, color: Colors.white);

  static TextStyle mediumSemibold =
      _commonStyle.copyWith(fontSize: 15.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle mediumBold = _commonStyle.copyWith(fontSize: 16.sp, fontFamily: PublicSans_Bold, color: Colors.white);

  static TextStyle smallBold = _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Bold, color: Colors.white);

  static TextStyle smallSemiBold =
      _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle smallRegular =
      _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Regular, color: Colors.white);

  static TextStyle smallRegularEmptyAddLocation =
      _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Regular, color: Colors.white, height: 1.4);

  static TextStyle smallMedium =
      _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Medium, color: Colors.white);

  static TextStyle xSmallRegular =
      _commonStyle.copyWith(fontSize: 12.sp, fontFamily: PublicSans_Regular, color: Colors.white);

  static TextStyle xSmallMedium =
      _commonStyle.copyWith(fontSize: 12.sp, fontFamily: PublicSans_Medium, color: Colors.white);

  static TextStyle xSmallBold =
  _commonStyle.copyWith(fontSize: 12.sp, fontFamily: PublicSans_SemiBold, color: Colors.white);

  static TextStyle xxSmallRegular = _commonStyle.copyWith(
    fontSize: 10.sp,
    fontFamily: PublicSans_Regular,
    color: Colors.white,
    height: 0,
  );

  /// displayMedium Text Style
  static TextStyle displayMedium = _commonStyle.copyWith(
    fontSize: 62,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  /// displaySmall Text Style
  static TextStyle displaySmall = _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Regular, color: hintText);

  /// headline Text Style
  static TextStyle headline = _commonStyle.copyWith(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  // static TextStyle titleMedium = _commonStyle.copyWith(
  //   fontSize: 14.sp,
  //   fontFamily: switzer_reuglar,
  //   color: grey_500,
  // );

  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 25,
    fontFamily: PublicSans_Medium,
    color: hintText,
  );

  /// bodyLargeBold Text Style
  static TextStyle bodyLarge = _commonStyle.copyWith(
    fontSize: 18.sp,
    fontFamily: PublicSans_Medium,
    letterSpacing: 0.5,
  );

  /// bodyLargeMedium Text Style
  static TextStyle bodyMedium = _commonStyle.copyWith(
    fontSize: 14.sp,
    fontFamily: PublicSans_Regular,
    color: hintText,
  );

  /// bodyLargeRegular Text Style
  static TextStyle titleText = _commonStyle.copyWith(fontSize: 16.sp, fontFamily: PublicSans_Medium, color: Colors.black);

  static TextStyle subTitleGrey =
      _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Regular, color: hintText);

  /// labelLarge Text Style
  static TextStyle label = _commonStyle.copyWith(fontSize: 14.sp, fontFamily: PublicSans_Medium, color: Colors.black);

  static TextStyle textFieldText =
      _commonStyle.copyWith(fontSize: 16.sp, fontFamily: PublicSans_Regular, color: hintText);

}

abstract class AppOtherTextStyle {
  static TextStyle _commonStyle = TextStyle(
    color: Colors.black,
    fontFamily: PublicSans_Medium,
  );

  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  static TextStyle bodyLarge = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  /// bodyLargeMedium Text Style
  static TextStyle bodyMedium = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  /// bodyLargeRegular Text Style
  static TextStyle bodySmall = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
}
