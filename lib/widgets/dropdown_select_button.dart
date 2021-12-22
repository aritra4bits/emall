import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownSelectButton extends StatefulWidget {
  final String? value;
  final String hintText;
  final Function(String?)? onChanged;
  final List<String> items;
  const DropdownSelectButton({Key? key, this.value, required this.hintText, required this.items, this.onChanged}) : super(key: key);

  @override
  State<DropdownSelectButton> createState() => _DropdownSelectButtonState();
}

class _DropdownSelectButtonState extends State<DropdownSelectButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0, bottom: 0),
      height: 37.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.sp),
      ),
      alignment: Alignment.center,
      child: DropdownButton<String>(
        value: widget.value,
        hint: Text(widget.hintText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFFCACACA))),
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: AppColors.textBlack),
        underline: const SizedBox(),
        onChanged: widget.onChanged,
        isExpanded: true,
        items: widget.items
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
