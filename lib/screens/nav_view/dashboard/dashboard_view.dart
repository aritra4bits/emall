import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/products_listing_manager/products_listing_manager.dart';
import 'package:emall/models/product_model/product_model.dart';
import 'package:emall/screens/nav_view/dashboard/views/app_bar_view.dart';
import 'package:emall/screens/nav_view/dashboard/views/category_view.dart';
import 'package:emall/screens/nav_view/dashboard/views/top_banner_view.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/widgets/heading_text.dart';
import 'package:emall/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  List onSaleProductItems = [
    ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
    ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
    ["laptop.png", 'MacBook 13"2018', "3999.90", "", 5.0, 24],
    ["hdtv.png", 'Samsung 32"TV', "599.80", "", 4.0, 214],
  ];

  List trendingProductItems = [
    ["milk.png", "Dutch Lady Purefarm UHT Milk - LOW FAT...", "2.90", "", 5.0, 24],
    ["router.png", "MILO ACTIV-GO 1Kg", "9.80", "19.80", 4.0, 214],
    ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
    ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
    ["milk.png", "Dutch Lady Purefarm UHT Milk - LOW FAT...", "2.90", "", 5.0, 24],
    ["router.png", "MILO ACTIV-GO 1Kg", "9.80", "19.80", 4.0, 214],
    ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
    ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
  ];

  @override
  void initState() {
    super.initState();
    productsListingManager.getOnSaleProducts();
    authManager.getUser();
    cartManager.getCountryCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const AppBarView(),
                const TopBannerView(),
                const CategoryView(),
                const HeadingText(title: 'ON SALE'),
              ]
            ),
          ),
          onSaleProducts(),
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  bannerAd(),
                  SizedBox(height: 30.h,),
                ]
            ),
          ),
          // const SliverToBoxAdapter(
          //   child: HeadingText(title: 'TRENDING'),
          // ),
          // trendingProducts(),
        ],
      ),
    );
  }

  Widget onSaleProducts(){
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      sliver: StreamBuilder<ApiResponse<ProductModel>?>(
          stream: productsListingManager.onSaleProductList,
          builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductModel>?> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return SliverToBoxAdapter(child: SizedBox(height: 200.sp, child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),))));
                case Status.COMPLETED:
                  return onSaleProductsView(snapshot.data?.data?.items??[]);
                case Status.NODATAFOUND:
                  return const SliverToBoxAdapter(child: SizedBox());
                case Status.ERROR:
                  return const SliverToBoxAdapter(child: SizedBox());
              }
            }
            return const SliverToBoxAdapter(child: SizedBox());
          }
      ),
    );
  }

  Widget onSaleProductsView(List<Item> products) {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.75),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ProductCard(productId: "${products[index].id}", productImageUrl: "https://mage2.fireworksmedia.com/pub/media/catalog/product${products[index].mediaGalleryEntries!.first.file!}", productTitle: products[index].name!, discountPrice: products[index].customAttributes![products[index].customAttributes!.indexWhere((element) => element.attributeCode == "special_price")].value, actualPrice: "${products[index].price}", rating: 4.4, reviewsCount: 5);
          },
          childCount: products.length,
        ),
    );
  }

  Widget bannerAd(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Image.asset('assets/images/placeholders/middle_banner.png'),
    );
  }

  Widget trendingProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.75),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(productId: "", productImageUrl: trendingProductItems[index][0], productTitle: trendingProductItems[index][1], discountPrice: trendingProductItems[index][2], actualPrice: trendingProductItems[index][3], rating: trendingProductItems[index][4], reviewsCount: trendingProductItems[index][5]);
            },
            childCount: trendingProductItems.length,
          ),
      ),
    );
  }
}
