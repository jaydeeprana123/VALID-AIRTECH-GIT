import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valid_airtech/Styles/my_colors.dart';

import '../Styles/constant.dart';

class CommonButton extends StatelessWidget {
  //String to be displayed

  CommonButton({
    Key? key,
    this.titleText,
    this.textColor,
    this.buttonColor,
    this.onCustomButtonPressed,
    this.borderColor,
    this.fontFamily,
    this.isShareButton = false,
    this.borderWidth,
  }) : super(key: key);

  final String? titleText;

  //button background color
  final Color? buttonColor;
  Color? borderColor;
  //text color
  Color? textColor;
  VoidCallback? onCustomButtonPressed;
  final double? borderWidth;

  bool? isShowIcon = false;
  final bool isShareButton;

  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          onPressed: onCustomButtonPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: buttonColor ?? color_brown_title,
            elevation: 0,
            minimumSize: Size.zero, // Set this
            padding: EdgeInsets.zero,
            // padding:
            // EdgeInsets.symmetric(horizontal: 0, vertical: 21.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
              side: BorderSide(color: borderColor!, width: borderWidth!),
            ),
          ),
          child: setBtnTxtMediumMedium(
            titleText!,
            16.sp,
            textColor!,
            FontStyle.normal,
            TextAlign.center,
            fontFamily: fontFamily,
          )),
    );
  }

  Text setBtnTxtMediumMedium(String text, double size, Color color,
      FontStyle fontStyle, TextAlign textAlign,
      {String? fontFamily}) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
          fontSize: size,
          fontFamily: fontFamily ?? PublicSans_Bold,
          color: color,
          height: 0,
          fontStyle: fontStyle),
    );
  }
}
