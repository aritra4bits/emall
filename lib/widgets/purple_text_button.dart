import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurpleTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const PurpleTextButton({Key? key, required this.onPressed, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: AppColors.purplePrimary, fontFamily: 'DinRegular', fontSize: 14.sp),),
      style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, padding: MaterialStateProperty.all(EdgeInsets.zero),
          visualDensity: VisualDensity.compact
      ),
    );
  }
}
