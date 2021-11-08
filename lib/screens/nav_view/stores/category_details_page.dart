import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String titleBarText;
  const CategoryDetailsPage({Key? key, required this.titleBarText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.arrow_back_ios_rounded,),
        ),
        titleSpacing: 0,
        title: AutoSizeText(titleBarText.toUpperCase(), style: const TextStyle(color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('STORES', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinBold'),),
            SizedBox(height: 10.h,),
            storeNameSection(title: 'SONY STORE'),
            SizedBox(height: 40.h,),
            storeDetails(),
          ],
        ),
      ),
    );
  }

  Widget storeNameSection({required String title}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
          SizedBox(width: 10.w,),
          Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

  static const List storeDetailsItems = [
    'Lorem ipsum dolor sit amet', 'Nulla facilisis dui id justo', 'Donec et magna', 'Nulla pretium ex'
  ];

  Widget storeDetails() {
    return ListView.builder(
      itemCount: storeDetailsItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(15.sp),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Text(storeDetailsItems[index], style: TextStyle(fontSize: 13.sp, color: const Color(0xFF6C6C6C), fontWeight: FontWeight.w600),),
      ),
    );
  }
}