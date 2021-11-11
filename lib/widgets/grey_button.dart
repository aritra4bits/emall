import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreyRoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  const GreyRoundButton({Key? key, required this.icon, required this.onPressed, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(icon, size: 24.sp, color: AppColors.textBlack,),
      onPressed: onPressed,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(backgroundColor ?? Colors.grey[100]),
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
    );
  }
}
