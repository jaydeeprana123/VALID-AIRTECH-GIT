import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:valid_airtech/Styles/my_icons.dart';



class CommonToolbar extends StatelessWidget {
  final String? iconClick;
  final String tvTitle;

  bool? isShowIcon = false;
  VoidCallback? onPressed;
  CommonToolbar({Key? key,this.iconClick, required this.tvTitle, this.onPressed, this.isShowIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onPressed ?? () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(iconBack)),
          Padding(
            padding: EdgeInsets.only(top: 0.sp),
            child: Center(
              child: Text(
                tvTitle,
                style: AppTextStyle.largeSemiBold.copyWith(fontSize: 18.sp,color: blackText),
              ),
            ),
          ),

          isShowIcon==true? SvgPicture.asset(iconNotification): SizedBox(width: 40.w,)
        ],
      ),
    );
  }
}
