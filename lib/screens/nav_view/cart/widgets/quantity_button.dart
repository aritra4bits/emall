import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityButton extends StatelessWidget {
  final int value;
  final Function(int) onChange;
  const QuantityButton({Key? key, required this.value, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: value < 20 ? (){
          onChange(value+1);
        } : null,
          icon: Icon(Icons.add, size: 20.sp, color: AppColors.textBlack,),
          visualDensity: VisualDensity.compact,
        ),
        Container(
          color: const Color(0xFFE9E9E9),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          child: Text(value.toString(), style: TextStyle(color: AppColors.textBlack, fontSize: 17.sp, fontWeight: FontWeight.bold, fontFamily: 'DinRegular'),),
        ),
        IconButton(onPressed: value > 1 ? (){
          onChange(value-1);
        } : null,
          icon: Icon(Icons.remove, size: 20.sp, color: AppColors.textBlack,),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
