import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';
import 'package:valid_airtech/Styles/my_icons.dart';



class CommonProgressDialog extends StatelessWidget {

  CommonProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      // Optional: Adds a semi-transparent background
      child: Center(
        child: CircularProgressIndicator(color: color_primary_dark,),
      ),
    );
  }
}
