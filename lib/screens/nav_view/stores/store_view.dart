import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/screens/nav_view/stores/widgets/store_banner_card.dart';
import 'package:emall/screens/category_details/views/store_category_card.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchBar(context),
            bannerList(),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              child: Text('CATEGORY', style: TextStyle(fontSize: 22.sp, color: const Color(0xFF373737), fontFamily: 'DinBold'),),
            ),
            categoryList(),
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.sp),
      padding: EdgeInsets.only(left: 15.w, right: 1.w, top: 1.h, bottom: 1.h),
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (value){
                if(value != '') {

                }
              },
              onChanged: (value) {

              },
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18.sp, color: Colors.white54),
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.white, size: 26.sp,),)
        ],
      ),
    );
  }

  List bannerItems = [
    ["SONY", "top_banner.png"],
    ["SAMSUNG", "top_banner2.png"],
  ];

  Widget bannerList() {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: bannerItems.length,
        itemBuilder: (context, index) => StoreBannerCard(title: bannerItems[index][0], imageUrl: bannerItems[index][1],),
      ),
    );
  }

  List categoryItems = [
    ["Digital Technology", "digital_technology.png"],
    ["Sundry & Services", "sundry.png"],
    ["Supermarket", "supermarket.png"],
    ["Leisure, Gift & Hobbies", "leisure.png"],
    ["Fashion", "fashion.png"],
    ["Food & Beverages", "food.png"],
    ["Health, Personal Care, Beauty & Wellness", "health.png"],
    ["Home Decor", "home.png"],
    ["Art Retail, Studio & Entertainment", "art.png"],
  ];

  Widget categoryList() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoryItems.length,
        itemBuilder: (BuildContext ctx, index) {
          return StoreCategoryCard(title: categoryItems[index][0], imageUrl: categoryItems[index][1],);
        });
  }
}
