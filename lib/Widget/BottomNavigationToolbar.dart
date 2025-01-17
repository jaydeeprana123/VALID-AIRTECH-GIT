import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:valid_airtech/Styles/my_icons.dart';



class BottomNavigationToolbar extends StatelessWidget {
  final String? iconClick;
  final String tvTitle;

  bool? isShowIcon = false;
  VoidCallback? onPressed;
  BottomNavigationToolbar({Key? key,this.iconClick, required this.tvTitle, this.onPressed, this.isShowIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: EdgeInsets.only(top: 0.sp),
            child: Center(
              child: Text(
                tvTitle,
                style: AppTextStyle.largeBold.copyWith(fontSize: 20.sp,color: blackText),
              ),
            ),
          ),

          isShowIcon==true? SvgPicture.asset(iconNotification): SizedBox(width: 40.w,)
        ],
      ),
    );
  }
}
