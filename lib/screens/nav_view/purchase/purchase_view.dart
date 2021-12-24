import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/address_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/screens/auth/login.dart';
import 'package:emall/screens/nav_view/cart/views/add_new_address_view.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/purple_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'edit_profile.dart';

class PurchaseView extends StatefulWidget {
  const PurchaseView({Key? key}) : super(key: key);

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    authManager.getUser();
  }

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
            accountInfoView(),
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

  Widget accountInfoView(){
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    accountInfo(snapshot.data?.data),
                    addressBook(snapshot.data?.data?.addresses)
                  ],
                );
              case Status.NODATAFOUND:
                return const SizedBox();
              case Status.ERROR:
                if(snapshot.data?.message != null && snapshot.data?.data?.id == null){
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginUserView(targetView: null,),)).then((value) {
                      if(value == true){
                        cartManager.getCartItemList();
                        cartManager.getCartTotal();
                      }
                    });
                  });
                  return const Center(
                    child: Text("Please login to view account information"),
                  );
                }
                return const SizedBox();
            }
          }
          return Container();
        }
    );
  }

  Widget accountInfo(Customer? userData){
    if(userData?.id != null){
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
                      Flexible(child: Text("${userData?.firstname??''}${userData?.firstname != null ? " " : ""}${userData?.lastname??''}", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 15.sp),)),
                      PurpleTextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileView(),));
                      }, title: 'Edit'),
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  Text(userData?.email??"", style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 15.sp),),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }

  }
  
  Widget addressBook(List<Address>? addresses){
    Address? defaultAddress = addresses?.lastWhere((element) => element.defaultShipping == true);
    if(defaultAddress != null){
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
                      PurpleTextButton(onPressed: (){
                        addressManager.setEditAddress(defaultAddress);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewAddressView(isNewWindow: true,),));
                      }, title: 'Edit'),
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  Text("${defaultAddress.firstname??''}${defaultAddress.firstname != null ? " " : ""}${defaultAddress.lastname??''}", style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                  defaultAddress.street != null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: defaultAddress.street!.map((e) => Text(e, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),).toList(),
                  ) : const SizedBox(),
                  Text("${defaultAddress.city??''}${defaultAddress.postcode != null ? ", " : ""}${defaultAddress.postcode??''}", style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                  defaultAddress.region?.region != null ? Text(defaultAddress.region?.region??'', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),) : const SizedBox(),
                  defaultAddress.countryId != null ? Text(defaultAddress.countryId??'', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),) : const SizedBox(),
                  SizedBox(height: 4.h,),
                  Text(defaultAddress.telephone??'', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Text('No addresses found', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 13.sp),),
        ),
      );
    }

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
