import 'package:emall/constants/colors.dart';
import 'package:emall/screens/nav_view/stores/views/shop_tab_view.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> with SingleTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late TabController tabController;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
          child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.arrow_back_ios_rounded,),
        ),
        titleSpacing: 0,
        title: searchBar(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h,),
            storeNameSection(title: 'SONY STORE'),
            tabBarView()
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 20.w),
      padding: EdgeInsets.only(left: 15.w, right: 1.w, top: 0, bottom: 0),
      height: 35.h,
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
                hintText: 'Search Store',
                hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black26),
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.search, color: const Color(0xFF727272), size: 22.sp,),)
        ],
      ),
    );
  }

  Widget storeNameSection({required String title}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
        SizedBox(width: 10.w,),
        Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: TextButton(
            onPressed: (){}, child: Text('Profile', style: TextStyle(color: AppColors.textBlack, fontSize: 13.sp, fontFamily: 'DinRegular'),),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
        ),
      ],
    );
  }

  Widget tabBarView(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: tabController,
          onTap: (index){
            setState(() {
              tabIndex = index;
            });
          },
          labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'DinRegular'),
          labelColor: AppColors.textBlack,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppColors.textBlack,
          tabs: const [
            Tab(
              text: '  Shop  ',
            ),
            Tab(
              text: '  All Products  ',
            ),
            Tab(
              text: '  Promotions  ',
            ),
          ],
        ),
        IndexedStack(
          children: [
            ShopTabView(),
            Text('all'),
            Text('promotions')
          ],
          index: tabIndex,
        ),
      ],
    );
  }
}
