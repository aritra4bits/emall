import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelCheckoutConfirmationView extends StatelessWidget {
  final VoidCallback onYes;
  const CancelCheckoutConfirmationView({Key? key, required this.onYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icons/cancel_checkout.png', height: 50.h, fit: BoxFit.fitHeight,),
            SizedBox(height: 10.h,),
            Text('Are you sure you want to cancel your checkout order?', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 16.sp),),
            SizedBox(height: 30.h,),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      onYes();
                      Navigator.pop(context);
                    },
                    child: Text('Yes', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'DinBold'),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[400])),
                  ),
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('No', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'DinBold'),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.purplePrimary)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
