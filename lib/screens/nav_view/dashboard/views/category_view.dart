import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List listItems = [
      ["", "On Sale"],
      ["", "Digital Technology"],
      ["", "Sundry & Services"],
      ["", "Supermarket"],
      ["", "Leisure Gift and Hobbies"],
      ["", "Fashion"],
      ["", "Health, Personal Care, Beauty & Wellness"],
      ["", "Home Decor"],
    ];

    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemCount: listItems.length,
        itemBuilder: (context, index) => listItem(listItems[index][0], listItems[index][1]),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget listItem(String iconPath, String title){
    return Container(
      width: 90.w,
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
          Icon(Icons.camera_alt, color: AppColors.teal, size: 28.sp,),
          const Spacer(flex: 1,),
          Flexible(flex: 2, child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 10.sp),)),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}
