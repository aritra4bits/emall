import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpDateController = TextEditingController();
  TextEditingController cardCvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter your card details:', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 16.sp),),
          SizedBox(height: 10.h,),
          textFieldBackground(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'NAME',
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.3),
                    fontFamily: 'DinBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                ),
                errorStyle: TextStyle(
                    color: Colors.red,
                    fontFamily: 'DinBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                ),
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              keyboardType: TextInputType.name,
            ),
          ),
          textFieldBackground(
            child: TextFormField(
              controller: cardNumberController,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'CARD NUMBER',
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.3),
                    fontFamily: 'DinBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                ),
                errorStyle: TextStyle(
                    color: Colors.red,
                    fontFamily: 'DinBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                ),
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                MaskedInputFormatter(
                  "#### #### #### ####",
                  allowedCharMatcher: RegExp(r'[0-9]+'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: textFieldBackground(
                  child: TextFormField(
                    controller: cardExpDateController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'MONTH / YEAR',
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(.3),
                          fontFamily: 'DinBold',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontFamily: 'DinBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: 'DinBold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CreditCardExpirationDateFormatter(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20.w,),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: textFieldBackground(
                        child: TextFormField(
                          controller: cardCvcController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'CVC',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(.3),
                              fontFamily: 'DinBold',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontFamily: 'DinBold',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          style: TextStyle(
                            color: AppColors.textBlack,
                            fontFamily: 'DinBold',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CreditCardCvcInputFormatter(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Icon(Icons.credit_card, size: 26.sp, color: Colors.grey,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Text('Your card details are protected using Pci DSS v3.2 security standards.', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 14.sp),),
          SizedBox(height: 30.h,),
          addressCardView(),
        ],
      ),
    );
  }

  Widget textFieldBackground({required Widget child}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sp),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: child,
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
        padding: EdgeInsets.only(bottom: 30.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
          ),
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
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }

  }
}
