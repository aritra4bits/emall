import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/purple_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseView extends StatefulWidget {
  const PurchaseView({Key? key}) : super(key: key);

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){navManager.updateNavIndex(0);}, icon: Icons.arrow_back_ios_rounded,),
        ),
        iconTheme: const IconThemeData(color: AppColors.textLightBlack),
        titleSpacing: 0,
        title: AutoSizeText('MY PURCHASE', style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accountInfo(),
            addressBook(),
            recentOrders(),
          ],
        ),
      ),
    );
  }
  
  Widget cardView({required Widget child}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 15.w, top: 9.h, bottom: 14.h),
      child: child,
    );
  }

  Widget accountInfo(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACCOUNT INFORMATION', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinMedium'),),
          SizedBox(height: 10.h,),
          cardView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ALEXANDER LE', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 15.sp),),
                    PurpleTextButton(onPressed: (){}, title: 'Edit'),
                  ],
                ),
                SizedBox(height: 5.h,),
                Text('a.lee@gmail.com', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 15.sp),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget addressBook(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ADDRESS BOOK', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinMedium'),),
          SizedBox(height: 10.h,),
          cardView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DEFAULT ADDRESS', style: TextStyle(color: AppColors.purplePrimary, fontFamily: 'DinBold', fontSize: 11.sp),),
                    PurpleTextButton(onPressed: (){}, title: 'Edit'),
                  ],
                ),
                SizedBox(height: 5.h,),
                Text('ALEXANDER LE', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                Text('Lorong Morib, Taman Desa,\n58100 Kuala Lumpur,\nWilayah Persekutuan Kuala Lumpur', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                SizedBox(height: 4.h,),
                Text('+6012-3456789', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget recentOrders(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('RECENT ORDERS', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinMedium'),),
              PurpleTextButton(onPressed: (){}, title: 'View All'),
            ],
          ),
          SizedBox(height: 5.h,),
          cardView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('ORDER #: ', style: TextStyle(color: AppColors.purplePrimary, fontFamily: 'DinBold', fontSize: 14.sp),),
                    Text('000000002', style: TextStyle(color: AppColors.purplePrimary, fontFamily: 'DinMedium', fontSize: 14.sp),),
                  ],
                ),
                Row(
                  children: [
                    Text('DATE: ', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 14.sp),),
                    Text('8/29/19', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 14.sp),),
                  ],
                ),
                Row(
                  children: [
                    Text('SHIP TO: ', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 14.sp),),
                    Text('ALEXANDER LE', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 14.sp),),
                  ],
                ),
                Row(
                  children: [
                    Text('ORDER TOTAL: ', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 14.sp),),
                    Text('RM345.88', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 14.sp),),
                  ],
                ),
                Row(
                  children: [
                    Text('STATUS: ', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 14.sp),),
                    Text('Delivered', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 14.sp),),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
