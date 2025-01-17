import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';




import '../Styles/my_icons.dart';

class SearchBarCommon extends StatefulWidget {
  const SearchBarCommon({Key? key, this.icon = "",this.title, this.onTap,this.hint,required this.controller,this.inputType,
  this.textInputAction,this.obscureText=false,this.focusNode,this.maxLine,this.onChanged,this.onTextChanged,
  this.bgColor,this.borderColor}): super(key: key);
  final String? icon;
  final String? title;
  final VoidCallback? onTap;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function? onChanged;
  final ValueChanged<String>? onTextChanged;
  final FocusNode? focusNode;
  final int? maxLine;
  final Color? bgColor;
  final Color? borderColor;

  @override
  State<SearchBarCommon> createState() => _SearchBarCommonState();
}

class _SearchBarCommonState extends State<SearchBarCommon> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
       // margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.borderColor!
          ),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            color: widget.bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              widget.icon!,
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                readOnly: false,
                style: AppTextStyle.smallRegular.copyWith(color: blackText),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: widget.hint,
                  hintStyle: AppTextStyle.smallRegular.copyWith(color: hintText),
                  labelStyle: AppTextStyle.smallRegular,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                obscureText: widget.obscureText,
               // focusNode: focusNode,
                maxLines: widget.maxLine,
                enabled: true,
                onSubmitted: (value){
                  if(widget.onTextChanged != null){
                    widget.onTextChanged!(value);
                  }
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).nextFocus();
                },
                onChanged: (value){

                  print("valueee"  + value);



                },


                // onChanged:
              ),
            ),
          ],
        ),
      ),
    );
  }
}
