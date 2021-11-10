import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/cart_page_manager.dart';
import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/screens/nav_view/cart/widgets/quantity_button.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.sp),
            child: GreyRoundButton(onPressed: (){navManager.updateNavIndex(0);}, icon: Icons.arrow_back_ios_rounded,),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              const AutoSizeText('MY CART', style: TextStyle(color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cartButton
                ),
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.all(8.sp),
                alignment: Alignment.center,
                child: Text('3', style: TextStyle(color: Colors.white, fontFamily: 'DinBold', fontSize: 15.sp),),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cartList(),
                    couponTextField(),
                  ],
                ),
              ),
            ),
            checkoutBar(),
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

  Widget cartList(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return cartItem(index: index, imageUrl: cartItems[index][0], title: cartItems[index][1], price: cartItems[index][2], quantity: cartItems[index][3]);
      }
    );
  }

  Widget cartItem({required int index, required String imageUrl, required String title, required String price, required int quantity}){
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        borderRadius: BorderRadius.circular(8),
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
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h),
                          child: IconButton(onPressed: (){}, visualDensity: VisualDensity.compact, icon: Image.asset('assets/images/icons/delete.png', width: 16.w, fit: BoxFit.fitWidth,)),
                        ),
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
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                          child: QuantityButton(value: quantity, onChange: (newQuantity) {
                            setState(() {
                              cartItems[index][3] = newQuantity;
                            });
                          },),
                        ),
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

  Widget couponTextField(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Do you have a coupon code?', style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinBold', fontWeight: FontWeight.bold, fontSize: 16.sp),),
          SizedBox(height: 5.h,),
          TextFieldWidget(
            controller: searchController,
            focusNode: focusNode,
            hintText: 'Enter coupon code',
            textInputAction: TextInputAction.search,
          ),
        ],
      ),
    );
  }

  Widget checkoutBar(){
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
                      Text('Checkout', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white,),
                    ],
                  ),
                  onPressed: (){
                    cartPageManager.updatePageIndex(1);
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
}
