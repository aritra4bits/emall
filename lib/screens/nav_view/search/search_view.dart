import 'package:emall/constants/colors.dart';
import 'package:emall/managers/product_details_manager/product_details_manager.dart';
import 'package:emall/managers/search_manager/search_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/models/product_model/product_model.dart';
import 'package:emall/screens/nav_view/stores/views/store_details_view.dart';
import 'package:emall/screens/product_details/product_details.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  static const List storeDetailsItems = [
    'Lorem ipsum dolor sit amet', 'Nulla facilisis dui id justo', 'Donec et magna', 'Nulla pretium ex'
  ];

  static const List productDetailsItems = [
    ['assets/images/placeholders/ps4.png', 'Sony PlayStation 4 Mega Pack 2'],
    ['assets/images/placeholders/controller.png', 'Sony DUALSHOCK®4 Wireless Controller (Jet Black)'],
  ];

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchManager.searchQuery.listen((searchQuery) {
      if(searchQuery != null){
        searchController.text = searchQuery;
        focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.clear();
    productDetailsManager.resetData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.sp),
            child: GreyRoundButton(onPressed: (){navManager.updateNavIndex(0);}, icon: Icons.arrow_back_ios_rounded,),
          ),
          titleSpacing: 0,
          title: searchBar(context),
        ),
        body: CustomScrollView(
          slivers: [
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: 15.w),
            //   sliver: SliverList(
            //     delegate: SliverChildListDelegate(
            //         [
            //           SizedBox(height: 20.h,),
            //           suggestions(),
            //           SizedBox(height: 30.h,),
            //           storeNameSection(title: 'SONY STORE'),
            //         ]
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h,)),
            productList(size),
            SliverToBoxAdapter(child: SizedBox(height: 20.h,)),
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
        borderRadius: BorderRadius.circular(6.sp),
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
                  searchManager.searchProduct(searchTerm: value);
                } else {
                  focusNode.requestFocus();
                  AppUtils.showToast("Please enter product name to search");
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
                hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black26),
              ),
            ),
          ),
          IconButton(onPressed: (){
            if(searchController.text.isNotEmpty){
              searchManager.searchProduct(searchTerm: searchController.text);
            } else {
              focusNode.requestFocus();
              AppUtils.showToast("Please enter product name to search");
            }
          }, icon: Icon(Icons.search, color: const Color(0xFF727272), size: 22.sp,),)
        ],
      ),
    );
  }

  Widget suggestions() {
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

  Widget storeNameSection({required String title}){
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

  Widget productList(Size size){
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: StreamBuilder<ApiResponse<ProductModel>?>(
          stream: productDetailsManager.productList,
          builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductModel>?> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return SliverToBoxAdapter(child: SizedBox(height: 200.sp, child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),))));
                case Status.COMPLETED:
                  return productListView(snapshot.data?.data?.items??[]);
                case Status.NODATAFOUND:
                  return const SliverToBoxAdapter(child: SizedBox());
                case Status.ERROR:
                  return const SliverToBoxAdapter(child: SizedBox());
              }
            }
            return SliverToBoxAdapter(child: SizedBox(
              height: size.height - 200.h,
              width: size.width,
              child: const Center(
                child: Text("Please enter product name to search"),
              ),
            ));
          }
      ),
    );
  }

  Widget productListView(List<Item> items){
    if(items.isEmpty){
      return const SliverToBoxAdapter(
        child: Center(
          child: Text("No products available. Try a different search term."),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return productCard(productId: items[index].id!, imageUrl: "https://mage2.fireworksmedia.com/pub/media/catalog/product${items[index].mediaGalleryEntries!.first.file!}", title: items[index].name!);
          },
        childCount: items.length,
      ),
    );
  }

  Widget productCard({required int productId, required String imageUrl, required String title}){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productId: productId.toString(),),));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
              child: Image.network(imageUrl, width: 100.w, height: 100.h, fit: BoxFit.contain,),
            ),
            Flexible(child: Padding(
              padding: EdgeInsets.only(left: 10.w, top: 20.h, bottom: 10.h, right: 10.w),
              child: Text(title, style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinBold', fontSize: 15.sp),),
            )),
          ],
        ),
      ),
    );
  }
}
