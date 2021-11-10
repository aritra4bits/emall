import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  const TextFieldWidget({Key? key, this.controller, this.hintText, this.focusNode, this.textInputAction, this.textCapitalization=TextCapitalization.none, this.textInputType, this.onSubmitted, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0, bottom: 0),
      height: 37.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: AppColors.textBlack),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFFCACACA)),
        ),
      ),
    );
  }
}
