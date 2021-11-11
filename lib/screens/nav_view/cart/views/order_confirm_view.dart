import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderConfirmView extends StatefulWidget {
  const OrderConfirmView({Key? key}) : super(key: key);

  @override
  _OrderConfirmViewState createState() => _OrderConfirmViewState();
}

class _OrderConfirmViewState extends State<OrderConfirmView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addressCard(),
        orderReview()
      ],
    );
  }

  Widget addressCard(){
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h, left: 15.w, right: 15.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Delivery Address', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 16.sp),),
            SizedBox(height: 20.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Image.asset('assets/images/icons/address.png', width: 22.w, fit: BoxFit.fitWidth,),
                ),
                SizedBox(width: 15.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ALEXANDER LE', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                      Text('No. 54 & 56, Jalan SS 15/4d,\nSs 15, 47500,\nSubang Jaya,\nSelangor.', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                      SizedBox(height: 4.h,),
                      Text('+6012-3456789', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List cartItems = [
    ['assets/images/placeholders/ps4.png', 'Sony PlayStation 4 Mega Pack 2', '1999.50', 1],
    ['assets/images/placeholders/hdtv.png', 'Sony 40 R350E Full HD TV', '1444.50', 1],
    ['assets/images/placeholders/headphones.png', 'Sony WH-CH510 Wireless Headphones', '199.50', 1],
  ];

  Widget orderReview(){
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h, left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Review', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 16.sp),),
          SizedBox(height: 20.h,),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return cartItem(index: index, imageUrl: cartItems[index][0], title: cartItems[index][1], price: cartItems[index][2], quantity: cartItems[index][3]);
            },
          ),
        ],
      ),
    );
  }

  Widget cartItem({required int index, required String imageUrl, required String title, required String price, required int quantity}){
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
              child: Image.asset(imageUrl, width: 100.w, fit: BoxFit.fitWidth,),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 20.h, right: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 17.sp),),
                              Text('x$quantity', style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 17.sp),),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 10.h, right: 10.w),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText("RM", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                                  AutoSizeText('${price.split('.').first}.', maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                                  AutoSizeText(price.split('.').last, maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
