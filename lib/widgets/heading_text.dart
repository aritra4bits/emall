import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingText extends StatelessWidget {
  final String title;
  const HeadingText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp),
      child: Text(title, style: TextStyle(color: Colors.black, fontSize: 20.h, letterSpacing: -1, fontWeight: FontWeight.w300,),),
    );
  }
}
