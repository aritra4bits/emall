import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/screens/product_details/product_carousel.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with TickerProviderStateMixin {

  late TabController _tabController;

  List onSaleProductItems = [
    ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
    ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
    ["laptop.png", 'MacBook 13"2018', "3999.90", "", 5.0, 24],
    ["hdtv.png", 'Samsung 32"TV', "599.80", "", 4.0, 214],
  ];

  List recommendedProductItems = [
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.arrow_back_ios_rounded,),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.shopping_cart,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w),
            child: GreyRoundButton(onPressed: (){Navigator.pop(context);}, icon: Icons.share,),
          )
        ],
      ),
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              children: [
                productCarouselView(),
                SizedBox(height: 10.h,),
                productPriceDetailsCard(),
                SizedBox(height: 10.h,),
                productDetailsCard(title: 'Product Details > ',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et'),
                SizedBox(height: 10.h,),
                productDetailsCard(title: 'Specifications > ',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et'),
                SizedBox(height: 10.h,),
                productDeliveryCard(title: 'Delivery', description: 'Next Day Delivery, KL & Selangor', deliveryAmount: 'RM15'),
                SizedBox(height: 10.h,),
                reviewsCard(reviewCount: 1245, ratings: 5.0, onViewAll: (){}),
                SizedBox(height: 10.h,),
                storeNameSection(title: 'SONY STORE'),
                SizedBox(height: 10.h,),
                storeTabView(context),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: addToCartButton(),
          ),
        ],
      ),
    );
  }

  Widget productCarouselView() {
    return ProductCarouselView(
      slideItems: [
        Image.asset('assets/images/placeholders/ps4.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/ps4.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/ps4.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/ps4.png', fit: BoxFit.fitHeight,),
      ],
    );
  }

  Widget productPriceDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("RM", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                  AutoSizeText('1990.', maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                  AutoSizeText("50", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.share, size: 24.sp, color: AppColors.greyIcon,),
                    onPressed: (){},
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.favorite, size: 24.sp, color: AppColors.greyIcon,),
                    onPressed: (){},
                  ),
                ],
              ),
            ],
          ),
          Text("Sony PlayStation 4 Mega Pack 2", maxLines: 2, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack),),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBarIndicator(
                rating: 5.0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemSize: 12,
                itemBuilder: (context, index) {
                  if(index+1 > 5.0) {
                    return const Icon(Icons.star_border, color: Colors.amber,);
                  } else {
                    return const Icon(Icons.star, color: Colors.amber);
                  }
                },
              ),
              Text("1245 reviews", style: TextStyle(fontSize: 12.sp),),
            ],
          ),
        ],
      ),
    );
  }

  Widget productDetailsCard({required String title, required String description}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          Text(description, style: TextStyle(fontSize: 12.sp),)
        ],
      ),
    );
  }

  Widget productDeliveryCard({required String title, required String description, required String deliveryAmount}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack, fontWeight: FontWeight.w600),),
              Text(description, style: TextStyle(fontSize: 12.sp, color: AppColors.textBlack),)
            ],
          ),
          const Spacer(),
          Text(deliveryAmount, style: TextStyle(fontSize: 16.sp, color: AppColors.textBlack, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  Widget reviewsCard({required int reviewCount, required VoidCallback onViewAll, required ratings}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ratings & Reviews[$reviewCount]", style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack, fontWeight: FontWeight.w600),),
              TextButton(onPressed: (){}, child: Text("View All", style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack, fontWeight: FontWeight.w600),),)
            ],
          ),
          reviewCard(name: 'John Doe', rating: 4.0, review: 'Product working. easy to arrange delivery within 14 days from order date.'),
          reviewCard(name: 'Jane Doe', rating: 4.0, review: 'Good.'),
        ],
      ),
    );
  }

  Widget reviewCard({required String name, required String review, required double rating}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: AppColors.textBlack, size: 20.sp,),
              SizedBox(width: 10.w,),
              Text(name, style: TextStyle(fontSize: 15.sp, color: AppColors.textBlack, fontWeight: FontWeight.w600),),
              const Spacer(),
              RatingBarIndicator(
                rating: rating,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemSize: 12,
                itemBuilder: (context, index) {
                  if(index+1 > rating) {
                    return const Icon(Icons.star_border, color: Colors.amber,);
                  } else {
                    return const Icon(Icons.star, color: Colors.amber);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 6.h,),
          Text(review, style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack),),
        ],
      ),
    );
  }

  Widget storeNameSection({required String title}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
        SizedBox(width: 10.w,),
        Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
      ],
    );
  }

  Widget storeTabView(BuildContext context) {
    return SizedBox(
      height: (recommendedProductItems.length/2).ceilToDouble() * 280,
      child: Column(
        children: <Widget>[
          TabBar(
            labelColor: Colors.grey,
            indicatorColor: Colors.grey,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            tabs: const <Widget>[
              Tab(
                text: 'Recommended',
              ),
              Tab(
                text: 'On Sale',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                recommendedProducts(),
                onSaleProducts()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget recommendedProducts() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: recommendedProductItems.length,
        itemBuilder: (BuildContext ctx, index) {
          return ProductCard(productImageUrl: recommendedProductItems[index][0], productTitle: recommendedProductItems[index][1], discountPrice: recommendedProductItems[index][2], actualPrice: recommendedProductItems[index][3], rating: recommendedProductItems[index][4], reviewsCount: recommendedProductItems[index][5]);
        });
  }

  Widget onSaleProducts() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: onSaleProductItems.length,
        itemBuilder: (BuildContext ctx, index) {
          return ProductCard(productImageUrl: onSaleProductItems[index][0], productTitle: onSaleProductItems[index][1], discountPrice: onSaleProductItems[index][2], actualPrice: onSaleProductItems[index][3], rating: onSaleProductItems[index][4], reviewsCount: onSaleProductItems[index][5]);
        });
  }

  Widget addToCartButton() {
    return Row(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: 60.h,
          width: 80.w,
          child: Image.asset('assets/images/icons/stores.png', color: Colors.black, height: 30, fit: BoxFit.fitHeight,),
        ),
        Expanded(
          child: SizedBox(
            height: 60.h,
            child: TextButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                backgroundColor: MaterialStateProperty.all(AppColors.cartButton),
              ),
              onPressed: (){}, child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 20.sp),),
            ),
          ),
        ),
      ],
    );
  }
}
