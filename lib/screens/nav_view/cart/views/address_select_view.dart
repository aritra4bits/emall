import 'package:emall/constants/colors.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/widgets/purple_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressSelectView extends StatefulWidget {
  const AddressSelectView({Key? key}) : super(key: key);

  @override
  _AddressSelectViewState createState() => _AddressSelectViewState();
}

class _AddressSelectViewState extends State<AddressSelectView> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return addressList();
  }

  List addressListItems = [
    ['ALEXANDER LE', 'No. 54 & 56, Jalan SS 15/4d,\nSs 15, 47500,\nSubang Jaya,\nSelangor.', '+6012-3456789'],
    ['ALEXANDER LE', 'Lorong Morib, Taman Desa,\n58100 Kuala Lumpur,\nWilayah Persekutuan\nKuala Lumpur', '+6012-3456789'],
  ];

  Widget addressList(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemCount: addressListItems.length+1,
      itemBuilder: (context, index) {
        if(index < addressListItems.length) {
          return addressCard(index: index);
        }else{
          return Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: PurpleTextButton(onPressed: (){
              cartPageManager.updatePageIndex(2);
            }, title: '+ Add another address', boldTitle: true,),
          );
        }
      },
    );
  }

  Widget addressCard({required int index}){
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: InkWell(
        onTap: (){
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: _selectedIndex == index ? AppColors.purplePrimary : Colors.white),
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
                    Text(addressListItems[index][0], style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', height: 1.6, fontSize: 15.sp),),
                    Text(addressListItems[index][1], style: TextStyle(color: AppColors.textBlack, height: 1.6, fontFamily: 'DinMedium', fontSize: 15.sp),),
                    SizedBox(height: 4.h,),
                    Text(addressListItems[index][2], style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinMedium', height: 1.6, fontSize: 15.sp),),
                  ],
                ),
              ),
              PurpleTextButton(onPressed: (){}, title: 'Edit'),
            ],
          ),
        ),
      ),
    );
  }
}
