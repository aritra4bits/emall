import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreBannerCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const StoreBannerCard({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: size.width/1.20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Image.asset('assets/images/placeholders/$imageUrl', fit: BoxFit.fitHeight,)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  children: [
                    Text(title, style: TextStyle(fontSize: 18.sp, color: AppColors.grey, fontWeight: FontWeight.w600),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textBlack,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
