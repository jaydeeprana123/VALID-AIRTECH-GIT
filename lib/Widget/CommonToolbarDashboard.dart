import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:valid_airtech/Styles/my_icons.dart';



class CommonToolbarDashboard extends StatelessWidget {
  final String? iconClick;
  final String tvTitle;

  bool? isShowIcon = false;
  VoidCallback? onPressed;
  CommonToolbarDashboard({Key? key,this.iconClick, required this.tvTitle, this.onPressed, this.isShowIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: onPressed ?? () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(iconMenu)),
          Expanded(
            flex: 1,
            child: Text(
              tvTitle,
              style: AppTextStyle.largeSemiBold.copyWith(fontSize: 18.sp,color: blackText),
            ),
          ),
          SvgPicture.asset(iconNotification),
          SizedBox(width: 12.w,),
          Image.asset(imgProfile,width: 40.w,height: 40.h,)
        ],
      ),
    );
  }
}
