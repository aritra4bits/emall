import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/models/cart/shipping_information_model.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
        addressCardView(),
        orderReviewView()
      ],
    );
  }

  Widget addressCardView(){
    return StreamBuilder<ApiResponse<Customer>?>(
        stream: authManager.customerData,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<Customer>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return Container(
                  color: AppColors.purplePrimary.withOpacity(0.3),
                  alignment: Alignment.center,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.ballScale,
                    colors: [AppColors.purplePrimary],
                  ),
                );
              case Status.COMPLETED:
                return addressCard(snapshot.data?.data?.addresses);
              case Status.NODATAFOUND:
                return SizedBox();
              case Status.ERROR:
                return SizedBox();
            }
          }
          return Container();
        }
    );
  }

  Widget addressCard(List<Address>? addresses){
    if(addresses != null && addresses.isNotEmpty){
      Address address = addresses.lastWhere((element) => element.defaultShipping == true);
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
                        Text("${address.firstname??''}${address.firstname != null ? " " : ""}${address.lastname??''}", style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                        address.street != null ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: address.street!.map((e) => Text(e, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),).toList(),
                        ) : const SizedBox(),
                        Text("${address.city??''}${address.postcode != null ? ", " : ""}${address.postcode??''}", style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                        address.region?.region != null ? Text(address.region?.region??'', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),) : const SizedBox(),
                        address.countryId != null ? Text(address.countryId??'', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),) : const SizedBox(),
                        SizedBox(height: 4.h,),
                        Text(address.telephone??'', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }

  }

  List cartItems = [
    ['assets/images/placeholders/ps4.png', 'Sony PlayStation 4 Mega Pack 2', '1999.50', 1],
    ['assets/images/placeholders/hdtv.png', 'Sony 40 R350E Full HD TV', '1444.50', 1],
    ['assets/images/placeholders/headphones.png', 'Sony WH-CH510 Wireless Headphones', '199.50', 1],
  ];

  Widget orderReviewView(){
    return StreamBuilder<ApiResponse<ShippingCartInformationModel>?>(
        stream: cartManager.shippingCartInformation,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<ShippingCartInformationModel>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return Container(
                  color: AppColors.purplePrimary.withOpacity(0.3),
                  alignment: Alignment.center,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.ballScale,
                    colors: [AppColors.purplePrimary],
                  ),
                );
              case Status.COMPLETED:
                return orderReview(snapshot.data?.data);
              case Status.NODATAFOUND:
                return SizedBox();
              case Status.ERROR:
                return SizedBox();
            }
          }
          return Container();
        }
    );
  }

  Widget orderReview(ShippingCartInformationModel? cartInfo){
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
            itemCount: cartInfo?.totals?.items?.length??0,
            itemBuilder: (context, index) {
              return cartItem(index: index, title: cartInfo?.totals?.items?[index].name??"", price: cartInfo?.totals?.items?[index].price?.toStringAsFixed(2)??"", quantity: cartInfo?.totals?.items?[index].qty??0);
            },
          ),
        ],
      ),
    );
  }

  Widget cartItem({required int index, String? imageUrl, required String title, required String price, required int quantity}){
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
            ) : SizedBox(width: 10.w,),
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
