import 'package:emall/constants/colors.dart';
import 'package:emall/main.dart';
import 'package:emall/managers/cart_page_manager.dart';
import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/managers/order_flow_manager.dart';
import 'package:emall/screens/nav_view/cart/views/address_select_view.dart';
import 'package:emall/screens/nav_view/cart/views/payment_view.dart';
import 'package:emall/screens/nav_view/cart/widgets/order_timeline_view.dart';
import 'package:emall/utils/app_global.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'order_confirm_view.dart';

class OrderFlowView extends StatefulWidget {
  const OrderFlowView({Key? key}) : super(key: key);

  @override
  State<OrderFlowView> createState() => _OrderFlowViewState();
}

class _OrderFlowViewState extends State<OrderFlowView> {

  int _selectedFlow = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){
            if(_selectedFlow > 0){
              orderFlowManager.updatePageIndex(_selectedFlow-1);
            }else{
              if(globalKey.currentContext != null){
                AppGlobal.cancelCheckoutDialog(globalKey.currentContext!, (){
                  cartPageManager.updatePageIndex(0);
                });
              }
            }
          }, icon: Icons.arrow_back_ios_rounded,),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OrderTimelineView(),
                  StreamBuilder<int?>(
                    stream: orderFlowManager.pageIndexStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.data != null){
                        _selectedFlow = snapshot.data!;
                      }
                      switch(_selectedFlow) {
                        case 0: {
                          return const AddressSelectView();
                        }
                        case 1: {
                          return const PaymentView();
                        }
                        case 2: {
                          return const OrderConfirmView();
                        }
                        default: {
                          return const AddressSelectView();
                        }
                      }

                    }
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<int?>(
              stream: orderFlowManager.pageIndexStream,
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.data != null){
                  _selectedFlow = snapshot.data!;
                }
                if(_selectedFlow >= 2){
                  return confirmOrderBar(_selectedFlow);
                }else{
                  return paymentBar(_selectedFlow);
                }
            }
          ),
        ],
      ),
    );
  }

  Widget paymentBar(int selectedFlow){
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0, offset: Offset(0,-2))]
      ),
      height: 54.h,
      child: Padding(
        padding: EdgeInsets.only(left: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('Shipping: ', style: TextStyle(color: AppColors.textBlack, fontSize: 12.sp, fontFamily: 'DinBold'),),
                      Text('RM 150', style: TextStyle(color: AppColors.productPrice, fontSize: 12.sp, fontFamily: 'DinBold'),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('TOTAl: ', style: TextStyle(color: AppColors.textBlack, fontSize: 17.sp, fontFamily: 'DinBold'),),
                      Text('RM 3643.5', style: TextStyle(color: AppColors.productPrice, fontSize: 17.sp, fontFamily: 'DinBold'),),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(selectedFlow == 0 ? 'Payment' : 'Confirmation', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white,),
                    ],
                  ),
                  onPressed: (){
                    orderFlowManager.updatePageIndex(selectedFlow+1);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.cartButton),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmOrderBar(int selectedFlow){
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0, offset: Offset(0,-2))]
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping (Flat - Rate - Fixed)', style: TextStyle(color: const Color(0xFF6E6E6E), fontFamily: 'DinRegular', fontSize: 16.sp),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RM", maxLines: 1,style: TextStyle(fontSize: 11.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                        Text('150', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal :', style: TextStyle(color: const Color(0xFF6E6E6E), fontFamily: 'DinBold', fontSize: 18.sp),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RM", maxLines: 1,style: TextStyle(fontSize: 13.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                        Text('3543.', style: TextStyle(fontSize: 18.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                        Text('50', style: TextStyle(fontSize: 13.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Voucher Code (RM5OFF)', style: TextStyle(color: const Color(0xFF82AEF9), fontFamily: 'DinRegular', fontSize: 16.sp),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('-', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                        Text("RM", maxLines: 1,style: TextStyle(fontSize: 12.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                        Text('5', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order total :', style: TextStyle(color: AppColors.productPrice, fontFamily: 'DinBold', fontSize: 23.sp),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RM", maxLines: 1,style: TextStyle(fontSize: 14.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
                        Text('3743.', style: TextStyle(fontSize: 23.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
                        Text('50', style: TextStyle(fontSize: 14.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            child: TextButton(
              child: Text('Proceed Order', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
              onPressed: (){
                orderFlowManager.reset();
                cartPageManager.reset();
                navManager.updateNavIndex(0);
                if(globalKey.currentContext != null){
                  AppGlobal.showOrderSuccessDialog(globalKey.currentContext!);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.cartButton),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
              ),
            ),
          ),
        ],
      ),
    );
  }
}
