import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valid_airtech/Styles/app_text_style.dart';
import 'package:valid_airtech/Styles/my_colors.dart';



class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    Key? key,
    this.focusNode,
    this.hint,
    this.labelText,
    required this.controller,
    this.onTextChanged,
    required this.onChanged,
    required this.inputType ,
    required this.textInputAction ,
    this.obscureText = false,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.focus,
    this.maxLine,
    this.maxLength,
    this.minLine,
    this.read,

  }) : super(key: key);

  final FocusNode? focusNode;
  final String? hint;
  final String? labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Function validator;
  final VoidCallback?  onChanged;
  final ValueChanged<String>? onTextChanged; // Updated from VoidCallback to ValueChanged<String>
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Focus? focus;
  final int? maxLine;
  final int? maxLength;
  final int? minLine;
  final bool? read;

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,

      ),
      child: TextFormField(
        readOnly: widget.read??false,
        style: AppTextStyle.mediumMedium.copyWith(color: blackText),
        keyboardType: widget.inputType,
        // keyboardType: numKeypad == false ? TextInputType.text : TextInputType.number,
        // inputFormatters: [
        //   numKeypad == true
        //       ? FilteringTextInputFormatter.digitsOnly
        //       : FilteringTextInputFormatter.singleLineFormatter,
        //   numKeypad == true ? LengthLimitingTextInputFormatter(13) : LengthLimitingTextInputFormatter(200),
        // ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          isDense: false,
          // you can change this with the top text like you want
          //   labelText: hint,
            hintText: widget.hint,
          labelStyle: AppTextStyle.mediumMedium.copyWith(color: hintText),
          hintStyle: AppTextStyle.mediumMedium?.copyWith(color: hintText),
          filled: false,
          counterText: "",
          labelText: widget.labelText,
          border: const OutlineInputBorder(),

          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: redSelectColor),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: borderColor),
          ),
          disabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: borderColor),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          prefixIconConstraints:const BoxConstraints(
              minHeight: 35,
              minWidth: 35
          ),
          suffixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24
          ),
          fillColor:focusNode.hasFocus ? Colors.white:hintText,

        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => widget.validator(value),
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        cursorColor: Colors.white,
        obscureText: widget.obscureText,
        focusNode: focusNode,
        maxLines: widget.maxLine,
        maxLength: widget.maxLength,
        minLines: widget.minLine,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).nextFocus();
          widget.onChanged;
        },
        onChanged: (value){

          print("valueee"  + value);

          if(widget.onTextChanged != null){
            widget.onTextChanged!(value);
          }

        },
        // onTap: widget.onChanged,

      ),
    );
  }
}