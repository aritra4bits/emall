import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/models/cart/cart_items_model.dart';
import 'package:emall/models/cart/cart_total_model.dart';
import 'package:emall/screens/nav_view/cart/widgets/quantity_button.dart';
import 'package:emall/services/web_service_components/api_response.dart';
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
        body: StreamBuilder<ApiResponse<CartItemsModel>?>(
            stream: cartManager.cartItemList,
            builder: (BuildContext context, AsyncSnapshot<ApiResponse<CartItemsModel>?> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
                  case Status.COMPLETED:
                    return cartView(snapshot.data?.data);
                  case Status.NODATAFOUND:
                    return SizedBox();
                  case Status.ERROR:
                    return SizedBox();
                }
              }
              return Container();
            }
        ),
      ),
    );
  }

  Widget cartView(CartItemsModel? cartItems){
    List<CartItem> cartListItem = cartItems?.items??[];
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
        title: Row(
          children: [
            AutoSizeText('MY CART', style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
            cartItems?.itemsCount != null && cartItems!.itemsCount! > 0 ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cartButton
              ),
              margin: EdgeInsets.only(left: 10.w),
              padding: EdgeInsets.all(8.sp),
              alignment: Alignment.center,
              child: Text("${cartItems.itemsCount}", style: TextStyle(color: Colors.white, fontFamily: 'DinBold', fontSize: 15.sp),),
            ) : const SizedBox(),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartListItem.isNotEmpty ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cartList(cartListItem),
                  cartListItem.isNotEmpty ? couponTextField() : const SizedBox(),
                ],
              ),
            ) : Container(
              alignment: Alignment.center,
              child: Text('Cart is empty', style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontFamily: 'DinBold', fontWeight: FontWeight.bold, fontSize: 16.sp),),
            ),
          ),
          cartListItem.isNotEmpty ? checkoutBar() : const SizedBox(),
        ],
      ),
    );
  }


  Widget cartList(List<CartItem> cartListItem){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemCount: cartListItem.length,
      itemBuilder: (context, index) {
        return cartItem(index: index, itemId: cartListItem[index].itemId, imageUrl: null, title: cartListItem[index].name??'', price: "${cartListItem[index].price??''}", quantity: cartListItem[index].qty??0);
      }
    );
  }

  Widget cartItem({required int index, required int? itemId, String? imageUrl, required String title, required String price, required int quantity}){
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white,
        child: Row(
          children: [
            imageUrl != null ? Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
              child: Image.asset(imageUrl, width: 100.w, fit: BoxFit.fitWidth,),
            ) : const SizedBox(),
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
                          child: IconButton(onPressed: (){
                            cartManager.deleteCartItem(itemId: itemId);
                          }, visualDensity: VisualDensity.compact, icon: Image.asset('assets/images/icons/delete.png', width: 16.w, fit: BoxFit.fitWidth,)),
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
                                  AutoSizeText('$price', maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                                  // AutoSizeText('${price.split('.').first}.', maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                                  // AutoSizeText(price.split('.').last, maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                                ],
                              ),
                            ],
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                          child: QuantityButton(value: quantity, onChange: (newQuantity) {
                            cartManager.updateCartItem(itemId: itemId, quantity: newQuantity);
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
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget checkoutBar(){
    return StreamBuilder<ApiResponse<CartTotalModel>?>(
        stream: cartManager.cartTotal,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<CartTotalModel>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
              case Status.COMPLETED:
                double grandTotal = snapshot.data?.data?.totals?.baseGrandTotal??0;
                double shippingAmount = snapshot.data?.data?.totals?.shippingAmount??0;
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0, offset: Offset(0,-2))]
                  ),
                  height: 54.h,
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
                                Text('RM ${shippingAmount.toStringAsFixed(2)}', style: TextStyle(color: AppColors.productPrice, fontSize: 12.sp, fontFamily: 'DinBold'),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('TOTAL: ', style: TextStyle(color: AppColors.textBlack, fontSize: 17.sp, fontFamily: 'DinBold'),),
                                Text('RM ${grandTotal.toStringAsFixed(2)}', style: TextStyle(color: AppColors.productPrice, fontSize: 17.sp, fontFamily: 'DinBold'),),
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
                );
              case Status.NODATAFOUND:
                return const SizedBox();
              case Status.ERROR:
                return const SizedBox();
            }
          }
          return Container();
        }
    );
  }
}
