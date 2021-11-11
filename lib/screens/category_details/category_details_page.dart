import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/screens/nav_view/stores/views/store_details_view.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String titleBarText;
  const CategoryDetailsPage({Key? key, required this.titleBarText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.arrow_back_ios_rounded,),
        ),
        iconTheme: const IconThemeData(color: AppColors.textLightBlack),
        titleSpacing: 0,
        title: AutoSizeText(titleBarText.toUpperCase(), style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('STORES', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinBold'),),
            SizedBox(height: 10.h,),
            storeNameSection(context: context, title: 'SONY STORE'),
            SizedBox(height: 40.h,),
            storeDetails(),
          ],
        ),
      ),
    );
  }

  Widget storeNameSection({required BuildContext context, required String title}){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreDetailsView(),));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
            SizedBox(width: 10.w,),
            Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }

  static const List storeDetailsItems = [
    'Lorem ipsum dolor sit amet', 'Nulla facilisis dui id justo', 'Donec et magna', 'Nulla pretium ex'
  ];

  Widget storeDetails() {
    return ListView.builder(
      itemCount: storeDetailsItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        padding: EdgeInsets.all(15.sp),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Text(storeDetailsItems[index], style: TextStyle(fontSize: 13.sp, color: const Color(0xFF6C6C6C), fontWeight: FontWeight.w600),),
      ),
    );
  }
}
