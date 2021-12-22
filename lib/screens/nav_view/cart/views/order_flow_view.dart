import 'package:emall/config/preferences.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/main.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/managers/ui_manager/order_flow_manager.dart';
import 'package:emall/models/cart/cart_total_model.dart';
import 'package:emall/models/cart/shipping_estimate_model.dart';
import 'package:emall/models/cart/shipping_information_model.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/screens/nav_view/cart/views/address_select_view.dart';
import 'package:emall/screens/nav_view/cart/views/payment_view.dart';
import 'package:emall/screens/nav_view/cart/widgets/order_timeline_view.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_global.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'order_confirm_view.dart';

class OrderFlowView extends StatefulWidget {
  const OrderFlowView({Key? key}) : super(key: key);

  @override
  State<OrderFlowView> createState() => _OrderFlowViewState();
}

class _OrderFlowViewState extends State<OrderFlowView> {

  int _selectedFlow = 0;
  bool isLoading = false;

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
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: Container(
            color: AppColors.purplePrimary.withOpacity(0.3),
            alignment: Alignment.center,
            child: const LoadingIndicator(
              indicatorType: Indicator.ballScale,
              colors: [AppColors.purplePrimary],
            ),
          ),
          child: Column(
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
                              return AddressSelectView(isLoading: (loading) {
                                if(mounted) {
                                  setState(() => isLoading = loading);
                                }
                              },);
                            }
                            case 1: {
                              return const PaymentView();
                            }
                            case 2: {
                              return const OrderConfirmView();
                            }
                            default: {
                              return AddressSelectView(isLoading: (loading) {
                                if(mounted) {
                                  setState(() => isLoading = loading);
                                }
                              },);
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
        ),
      ),
    );
  }

  Widget paymentBar(int selectedFlow){
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
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0, offset: Offset(0,-2))],
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
                                Text(selectedFlow == 0 ? 'Payment' : 'Confirmation', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
                                Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white,),
                              ],
                            ),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              Customer? customerDetails = authManager.getUserDetails();
                              if(customerDetails?.id != null){
                                if(customerDetails?.addresses != null){
                                  Address? address = customerDetails!.addresses!.lastWhere((element) => element.defaultShipping == true);
                                  Map estimateParams = {
                                    "address": {
                                      "region": address.region?.region,
                                      "region_id": address.region?.regionId,
                                      "region_code": address.region?.regionCode,
                                      "country_id": address.countryId,
                                      "street": address.street,
                                      "postcode": address.postcode,
                                      "city": address.city,
                                      "firstname": address.firstname,
                                      "lastname": address.lastname,
                                      "customer_id": customerDetails.id,
                                      "email": customerDetails.email,
                                      "telephone": address.telephone,
                                      "same_as_billing": 1
                                    },
                                  };
                                  List<ShippingEstimateModel>? shippingEstimate = await cartManager.getShippingEstimate(params: estimateParams);
                                  if(shippingEstimate?.first.amount != null){
                                    Map shippingParams = {
                                      "addressInformation": {
                                        "shipping_address": {
                                          "region": address.region?.region,
                                          "region_id": address.region?.regionId,
                                          "region_code": address.region?.regionCode,
                                          "country_id": address.countryId,
                                          "street": address.street,
                                          "postcode": address.postcode,
                                          "city": address.city,
                                          "firstname": address.firstname,
                                          "lastname": address.lastname,
                                          "email": customerDetails.email,
                                          "telephone": address.telephone,
                                        },
                                        "billing_address": {
                                          "region": address.region?.region,
                                          "region_id": address.region?.regionId,
                                          "region_code": address.region?.regionCode,
                                          "country_id": address.countryId,
                                          "street": address.street,
                                          "postcode": address.postcode,
                                          "city": address.city,
                                          "firstname": address.firstname,
                                          "lastname": address.lastname,
                                          "email": customerDetails.email,
                                          "telephone": address.telephone,
                                        },
                                        "shipping_carrier_code": shippingEstimate?.first.carrierCode??"",
                                        "shipping_method_code": shippingEstimate?.first.methodCode
                                      }
                                    };
                                    ShippingCartInformationModel? shippingInfo = await cartManager.setShippingInformation(params: shippingParams);
                                    if(shippingInfo?.totals?.shippingAmount != null){
                                      cartManager.getCartTotal(withLoading: true);
                                      orderFlowManager.updatePageIndex(selectedFlow+1);
                                    }
                                  }
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.cartButton),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
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

  Widget confirmOrderBar(int selectedFlow){
    return StreamBuilder<ApiResponse<ShippingCartInformationModel>?>(
        stream: cartManager.shippingCartInformation,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<ShippingCartInformationModel>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
              case Status.COMPLETED:
                String? currency = snapshot.data?.data?.totals?.quoteCurrencyCode;
                TotalSegmentInfo? subTotal = snapshot.data?.data?.totals?.totalSegments?.lastWhere((element) => element.code == "subtotal");
                TotalSegmentInfo? shipping = snapshot.data?.data?.totals?.totalSegments?.lastWhere((element) => element.code == "shipping");
                TotalSegmentInfo? tax = snapshot.data?.data?.totals?.totalSegments?.lastWhere((element) => element.code == "tax");
                TotalSegmentInfo? grandTotal = snapshot.data?.data?.totals?.totalSegments?.lastWhere((element) => element.code == "grand_total");
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
                                Text(shipping?.title??"", style: TextStyle(color: const Color(0xFF6E6E6E), fontFamily: 'DinRegular', fontSize: 16.sp),),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currency??"", maxLines: 1,style: TextStyle(fontSize: 11.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                    Text('${shipping?.value?.toStringAsFixed(2).split(".").first}.', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                    Text('${shipping?.value?.toStringAsFixed(2).split(".").last}', style: TextStyle(fontSize: 11.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${subTotal?.title??""} :', style: TextStyle(color: const Color(0xFF6E6E6E), fontFamily: 'DinBold', fontSize: 18.sp),),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currency??"", maxLines: 1,style: TextStyle(fontSize: 13.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                    Text('${subTotal?.value?.toStringAsFixed(2).split(".").first}', style: TextStyle(fontSize: 18.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                    Text('${subTotal?.value?.toStringAsFixed(2).split(".").last}', style: TextStyle(fontSize: 13.sp, fontFamily: 'DinBold', color: const Color(0xFF6E6E6E),),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('Voucher Code (RM5OFF)', style: TextStyle(color: const Color(0xFF82AEF9), fontFamily: 'DinRegular', fontSize: 16.sp),),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text('-', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                            //         Text("RM", maxLines: 1,style: TextStyle(fontSize: 12.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                            //         Text('0', style: TextStyle(fontSize: 16.sp, fontFamily: 'DinBold', color: const Color(0xFF82AEF9)),),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${grandTotal?.title??""} :', style: TextStyle(color: AppColors.productPrice, fontFamily: 'DinBold', fontSize: 23.sp),),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currency??"", maxLines: 1,style: TextStyle(fontSize: 14.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
                                    Text('${grandTotal?.value?.toStringAsFixed(2).split(".").first}.', style: TextStyle(fontSize: 23.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
                                    Text('${grandTotal?.value?.toStringAsFixed(2).split(".").last}', style: TextStyle(fontSize: 14.sp, fontFamily: 'DinBold', color: AppColors.productPrice),),
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
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            Customer? userDetails = authManager.getUserDetails();
                            Address? address = userDetails?.addresses?.lastWhere((element) => element.defaultShipping == true);
                            if(address != null){
                              Map params = {
                                "paymentMethod": {
                                  "method": "checkmo"
                                },
                                "billing_address": {
                                  "email": userDetails?.email??"",
                                  "region": address.region?.region,
                                  "region_id": address.region?.regionId,
                                  "region_code": address.region?.regionCode,
                                  "country_id": address.countryId,
                                  "street": address.street,
                                  "postcode": address.postcode,
                                  "city": address.city,
                                  "telephone": address.telephone,
                                  "firstname": address.firstname,
                                  "lastname": address.lastname
                                }
                              };
                              bool? result = await cartManager.placeOrder(params: params);
                              if(result == true){
                                await preferences.deleteValueByKey(preferences.quoteId);
                                await authManager.getUser();
                                orderFlowManager.reset();
                                cartPageManager.reset();
                                navManager.updateNavIndex(0);
                                if(globalKey.currentContext != null){
                                  AppGlobal.showOrderSuccessDialog(globalKey.currentContext!);
                                }
                              }
                            } else {
                              AppUtils.showToast("Please add a shipping address before placing order.");
                            }
                            setState(() {
                              isLoading = false;
                            });
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
