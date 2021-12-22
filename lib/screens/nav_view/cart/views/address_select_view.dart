import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/address_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/models/cart/shipping_estimate_model.dart';
import 'package:emall/models/cart/shipping_information_model.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/purple_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AddressSelectView extends StatefulWidget {
  final Function(bool) isLoading;
  const AddressSelectView({Key? key, required this.isLoading}) : super(key: key);

  @override
  _AddressSelectViewState createState() => _AddressSelectViewState();
}

class _AddressSelectViewState extends State<AddressSelectView> {

  @override
  Widget build(BuildContext context) {
    return addressListView();
  }

  List addressListItems = [
    ['ALEXANDER LE', 'No. 54 & 56, Jalan SS 15/4d,\nSs 15, 47500,\nSubang Jaya,\nSelangor.', '+6012-3456789'],
    ['ALEXANDER LE', 'Lorong Morib, Taman Desa,\n58100 Kuala Lumpur,\nWilayah Persekutuan\nKuala Lumpur', '+6012-3456789'],
  ];

  Widget addressList(List<Address>? addresses){
    if(addresses != null){
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        itemCount: addresses.length+1,
        itemBuilder: (context, index) {
          if(index < addresses.length) {
            return addressCard(index: index, address: addresses[index]);
          }else{
            return Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: PurpleTextButton(onPressed: (){
                addressManager.resetData();
                cartPageManager.updatePageIndex(2);
              }, title: '+ Add another address', boldTitle: true,),
            );
          }
        },
      );
    } else {
      return SizedBox();
    }

  }

  Widget addressListView(){
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
                return addressList(snapshot.data?.data?.addresses);
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

  Widget addressCard({required Address address, required int index}){
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: InkWell(
        onTap: () async {
          Customer? userDetails = authManager.getUserDetails();
          if(userDetails != null){
            List<Address> addresses = userDetails.addresses!.map((e) {
              if(e.id == address.id){
                return Address(
                    id: e.id,
                    region: e.region,
                    customerId: e.customerId,
                    regionId: e.regionId,
                    countryId: e.countryId,
                    street: e.street,
                    telephone: e.telephone,
                    postcode: e.postcode,
                    city: e.city,
                    firstname: e.firstname,
                    lastname: e.lastname,
                    defaultBilling: true,
                    defaultShipping: true
                );
              } else {
                return Address(
                    id: e.id,
                    region: e.region,
                    customerId: e.customerId,
                    regionId: e.regionId,
                    countryId: e.countryId,
                    street: e.street,
                    telephone: e.telephone,
                    postcode: e.postcode,
                    city: e.city,
                    firstname: e.firstname,
                    lastname: e.lastname,
                    defaultBilling: false,
                    defaultShipping: false
                );
              }
            }).toList();
            Map params = {
              "customer": {
                "email": userDetails.email,
                "firstname": userDetails.firstname,
                "lastname": userDetails.lastname,
                "addresses": List<dynamic>.from(addresses.map((x) => x.toJson()))
              }
            };
            widget.isLoading(true);
            await authManager.updateUser(params: params, withLoading: false);
            widget.isLoading(false);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: address.defaultShipping == true ? AppColors.purplePrimary : Colors.white),
          ),
          padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
          child: Row(
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
              PurpleTextButton(onPressed: (){
                addressManager.setEditAddress(address);
                cartPageManager.updatePageIndex(2);
              }, title: 'Edit'),
            ],
          ),
        ),
      ),
    );
  }
}
