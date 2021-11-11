import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/screens/nav_view/stores/views/store_details_view.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreProfileView extends StatelessWidget {
  const StoreProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.arrow_back_ios_rounded),
        ),
        iconTheme: const IconThemeData(color: AppColors.textLightBlack),
        titleSpacing: 0,
        title: AutoSizeText('PROFILE', style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            storeNameSection(context: context, title: 'SONY STORE'),
            SizedBox(height: 20.h,),
            storeDetails(size),
            SizedBox(height: 20.h,),
            promotions(size),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
          SizedBox(width: 10.w,),
          Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

  Widget storeDetails(Size size) {
    return Column(
      children: [
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at placerat ante. Nunc vel est imperdiet, auctor diam dignissim, commodo erat. Mauris eu augue sapien. Fusce rhoncus libero ut leo porttitor, sed pharetra ligula rutrum. Sed vestibulum, metus ut mattis porta, ex lorem vulputate diam, vel pretium felis sem sit amet nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc non dolor vel risus volutpat mattis. Fusce sagittis turpis lectus, et gravida nulla rhoncus ac. Donec euismod orci orci. Duis eget cursus libero, vel aliquam ligula. Duis porta venenatis quam vel congue.",
          style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontSize: 13.sp),
        ),
        SizedBox(height: 20.h),
        detailsTile(imageUrl: 'assets/images/icons/location.png', title: 'UG - 1C & Part 2'),
        detailsTile(imageUrl: 'assets/images/icons/timings.png', title: '10:00am - 10:00pm'),
        detailsTile(imageUrl: 'assets/images/icons/call.png', title: '1300-363-992'),
        detailsTile(imageUrl: 'assets/images/icons/website.png', title: 'www.sony.com.my'),
        Image.asset('assets/images/placeholders/company_footer.png', width: size.width, fit: BoxFit.fitWidth,),
        SizedBox(height: 20.h,),
      ],
    );
  }

  Widget detailsTile({required String imageUrl, required String title}){
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Image.asset(imageUrl, width: 16.5.w, fit: BoxFit.fitWidth,),
          SizedBox(width: 10.w,),
          Text(title, style: TextStyle(color: Colors.black, fontFamily: 'DinBold', fontSize: 16.sp),),
        ],
      ),
    );
  }

  static const List promotionItems = [
    'assets/images/placeholders/top_banner.png',
    'assets/images/placeholders/company_banner.png',
  ];

  Widget promotions(Size size){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PROMOTIONS', style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
        SizedBox(height: 15.h,),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: promotionItems.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: Image.asset(promotionItems[index], width: size.width, fit: BoxFit.fitWidth,),
            ),
          ),
        ),
      ],
    );
  }
}
