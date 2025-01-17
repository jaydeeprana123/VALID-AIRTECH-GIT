import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:valid_airtech/Widget/CommonButton.dart';


class CommonDialog extends StatelessWidget {
  final String? icon;
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;


  const CommonDialog({Key? key,this.icon, required this.title,this.subTitle,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:  EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(icon!,width: 44.w,height: 44.h,),
                SizedBox(height: 12.h,),
                Text(
                    title,
                    style: AppTextStyle.largeBold.copyWith(fontSize: 18.sp,color: blackText),
                    textAlign: TextAlign.center
                ),
                SizedBox(height: 4.h,),
                // We’ve sent a password reset link to the email address you provided. Please check your inbox.
                Text(
                    subTitle!,
                    style: AppTextStyle.smallRegular.copyWith(color: blackText,height: 1.3),
                    textAlign: TextAlign.center
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CommonButton(
              titleText: "Sign In",
              textColor:  Colors.white,
              buttonColor: redSelectColor,
              onCustomButtonPressed: onTap,
              borderColor: btnDisableBgColor,
              borderWidth: 0,
            ),
          ),

        ],
      ),
    );
  }
}
