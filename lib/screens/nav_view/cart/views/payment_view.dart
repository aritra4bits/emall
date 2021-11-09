import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          addressCard(),
        ],
      ),
    );
  }

  Widget textFieldBackground({required Widget child}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: child,
    );
  }

  Widget addressCard(){
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
                  Text('ALEXANDER LE', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                  Text('No. 54 & 56, Jalan SS 15/4d,\nSs 15, 47500,\nSubang Jaya,\nSelangor.', style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                  SizedBox(height: 4.h,),
                  Text('+6012-3456789', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
