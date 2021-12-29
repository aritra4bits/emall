import 'dart:io';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/config/global.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/product_details_manager/product_details_manager.dart';
import 'package:emall/managers/products_listing_manager/products_listing_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/models/product_model/product_model.dart';
import 'package:emall/screens/auth/login.dart';
import 'package:emall/screens/nav_view/cart/widgets/quantity_button.dart';
import 'package:emall/screens/nav_view/stores/views/store_details_view.dart';
import 'package:emall/screens/product_details/product_carousel.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({Key? key, required this.productId}) : super(key: key);

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

  List recommendedProductItems = [];
  // [
  //   ["milk.png", "Dutch Lady Purefarm UHT Milk - LOW FAT...", "2.90", "", 5.0, 24],
  //   ["router.png", "MILO ACTIV-GO 1Kg", "9.80", "19.80", 4.0, 214],
  //   ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
  //   ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
  //   ["milk.png", "Dutch Lady Purefarm UHT Milk - LOW FAT...", "2.90", "", 5.0, 24],
  //   ["router.png", "MILO ACTIV-GO 1Kg", "9.80", "19.80", 4.0, 214],
  //   ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24],
  //   ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214],
  // ];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    productDetailsManager.getProducts(productId: widget.productId);
    productsListingManager.getOnSaleProducts();
  }

  @override
  void dispose() {
    super.dispose();
    productDetailsManager.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Container(
        color: AppColors.purplePrimary.withOpacity(0.3),
        alignment: Alignment.center,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: [AppColors.purplePrimary],
        ),
      ),
      child: Scaffold(
        body: StreamBuilder<ApiResponse<ProductModel>?>(
            stream: productDetailsManager.productList,
            builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductModel>?> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return Container(
                      color: AppColors.purplePrimary.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: const LoadingIndicator(
                        indicatorType: Indicator.ballScale,
                        colors: [AppColors.purplePrimary],
                      ),
                    );
                  case Status.COMPLETED:
                    return productDetails(snapshot.data?.data?.items??[]);
                  case Status.NODATAFOUND:
                    return SizedBox();
                  case Status.ERROR:
                    return SizedBox();
                }
              }
              return Container();
            }
        ),
      ),
    );
  }

  Widget productDetails(List<Item> products){
    Item product = products.first;
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
            child: GreyRoundButton(onPressed: (){navManager.updateNavIndex(3); Navigator.pop(context);}, icon: Icons.shopping_cart,),
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
            child: Builder(
              builder: (context) {
                int shortDescIndex = product.customAttributes!.indexWhere((element) => element.attributeCode == "short_description");
                int descIndex = product.customAttributes!.indexWhere((element) => element.attributeCode == "description");
                return Column(
                  children: [
                    productCarouselView(product),
                    SizedBox(height: 10.h,),
                    productPriceDetailsCard(product),
                    SizedBox(height: 10.h,),
                    InkWell(
                      onTap: (){
                        openBottomSheet(context, detailsBottomSheet(context, product));
                      },
                      child: productDetailsCard(title: 'Product Details > ',
                          description: shortDescIndex >= 0 ? product.customAttributes![shortDescIndex].value : "No information provided."),
                    ),
                    SizedBox(height: 10.h,),
                    InkWell(
                      onTap: (){
                        openBottomSheet(context, specsBottomSheet(context, product));
                      },
                      child: productDetailsCard(title: 'Specifications > ',
                          description: descIndex >= 0 ? product.customAttributes![descIndex].value : "No information provided."),
                    ),
                    SizedBox(height: 10.h,),
                    // productDeliveryCard(title: 'Delivery', description: 'Next Day Delivery, KL & Selangor', deliveryAmount: 'RM15'),
                    // SizedBox(height: 10.h,),
                    reviewsCard(reviewCount: 1245, ratings: 5.0, onViewAll: (){}),
                    SizedBox(height: 10.h,),
                    // storeNameSection(title: 'SONY STORE'),
                    // SizedBox(height: 10.h,),
                    storeTabView(context),
                    SizedBox(height: 150.h,),
                  ],
                );
              }
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: addToCartButton(product),
          ),
        ],
      ),
    );
  }

  Widget productCarouselView(Item product) {
    return ProductCarouselView(
      slideItems: product.mediaGalleryEntries!.map((e) => Image.network("https://mage2.fireworksmedia.com/pub/media/catalog/product${e.file}")).toList(),
    );
  }

  Widget productPriceDetailsCard(Item product) {
    int specialPriceIndex = product.customAttributes!.indexWhere((element) => element.attributeCode == "special_price");
    String? specialPrice = specialPriceIndex >= 0 ? double.parse(product.customAttributes![specialPriceIndex].value).toStringAsFixed(2) : null;
    String? price = product.price?.toStringAsFixed(2);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
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
                  AutoSizeText("${specialPrice != null ? specialPrice.split('.').first : price?.split(".").first}.", maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                  AutoSizeText("${specialPrice != null ? specialPrice.split('.').last : price?.split(".").last}", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
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
          Text("${product.name}", maxLines: 2, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack),),
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
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          Html(data: description, style: {
            "li": Style(
              fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
            ),
            "p": Style(
              fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
            ),
          })
        ],
      ),
    );
  }

  Widget productDeliveryCard({required String title, required String description, required String deliveryAmount}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
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
          borderRadius: BorderRadius.circular(8.sp),
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
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreDetailsView(),));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/placeholders/sony.png', height: 60.h, fit: BoxFit.fitHeight,),
          SizedBox(width: 10.w,),
          Text(title, style: TextStyle(fontSize: 20.sp, color: AppColors.textLightBlack, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

  Widget storeTabView(BuildContext context) {
    return SizedBox(
      // height: (recommendedProductItems.length/2).ceilToDouble() * 280,
      height: MediaQuery.of(context).size.height/1.5,
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
    if(recommendedProductItems.isNotEmpty) {
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
          return ProductCard(productId: "", productImageUrl: recommendedProductItems[index][0], productTitle: recommendedProductItems[index][1], discountPrice: recommendedProductItems[index][2], actualPrice: recommendedProductItems[index][3], rating: recommendedProductItems[index][4], reviewsCount: recommendedProductItems[index][5]);
        });
    } else {
      return const Center(
        child: Text("No products found"),
      );
    }
  }

  Widget onSaleProducts(){
    return StreamBuilder<ApiResponse<ProductModel>?>(
        stream: productsListingManager.onSaleProductList,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductModel>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
              case Status.COMPLETED:
                return onSaleProductsView(snapshot.data?.data?.items??[]);
              case Status.NODATAFOUND:
                return SizedBox();
              case Status.ERROR:
                return SizedBox();
            }
          }
          return Container();
        }
    );
  }

  Widget onSaleProductsView(List<Item> products) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, index) {
          return ProductCard(productId: "${products[index].id}", productImageUrl: "https://mage2.fireworksmedia.com/pub/media/catalog/product${products[index].mediaGalleryEntries!.first.file!}", productTitle: products[index].name!, discountPrice: products[index].customAttributes![products[index].customAttributes!.indexWhere((element) => element.attributeCode == "special_price")].value, actualPrice: "${products[index].price}", rating: 4.4, reviewsCount: 5);
        });
  }

  Widget addToCartButton(Item product) {
    return Row(
      children: [
        // Material(
        //   color: Colors.white,
        //   child: Container(
        //     alignment: Alignment.center,
        //     height: 60.h,
        //     width: 80.w,
        //     child: IconButton(
        //       onPressed: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreDetailsView(),));
        //       },
        //       padding: EdgeInsets.zero,
        //       icon: Image.asset('assets/images/icons/stores.png', color: Colors.black, height: 30, fit: BoxFit.fitHeight,),
        //     ),
        //   ),
        // ),
        Expanded(
          child: SizedBox(
            height: 60.h,
            child: TextButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                backgroundColor: MaterialStateProperty.all(AppColors.cartButton),
              ),
              onPressed: (){
                openBottomSheet(context, addToCart(context, product));
              }, child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 20.sp),),
            ),
          ),
        ),
      ],
    );
  }

  openBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return child;
        });
  }

  Widget detailsBottomSheet(BuildContext context, Item product){
    int shortDescIndex = product.customAttributes!.indexWhere((element) => element.attributeCode == "short_description");
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("PRODUCT DETAILS",
                style: TextStyle(color: const Color(0xFF3B3A3A), fontSize: 15.sp, fontFamily: 'DinRegular'),
              ),
              shortDescIndex >= 0 ? Html(data: product.customAttributes![shortDescIndex].value, style: {
                "li": Style(
                  fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
                ),
                "p": Style(
                  fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
                ),
              }) : const Text("No information provided."),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.close, color: const Color(0xFF3B3A3A), size: 26.sp,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget specsBottomSheet(BuildContext context, Item product){
    int descIndex = product.customAttributes!.indexWhere((element) => element.attributeCode == "description");
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("SPECIFICATIONS",
                style: TextStyle(color: const Color(0xFF3B3A3A), fontSize: 15.sp, fontFamily: 'DinRegular'),
              ),
              descIndex >= 0 ? Html(data: product.customAttributes![descIndex].value, style: {
                "li": Style(
                  fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
                ),
                "p": Style(
                  fontSize: FontSize(Platform.isAndroid ? 13.sp : 12.sp),
                ),
              }) : const Text("No information provided."),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.close, color: const Color(0xFF3B3A3A), size: 26.sp,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget addToCart(BuildContext context, Item product){
    return Stack(
      children: [
        SingleChildScrollView(
          child: ProductItem(
            imageUrl: "https://mage2.fireworksmedia.com/pub/media/catalog/product${product.mediaGalleryEntries?.first.file}",
            title: product.name??"",
            price: "${product.price}",
            onCheckout: (quantity) async {
              if(ApplicationGlobal.bearerToken.isEmpty){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUserView(targetView: ProductDetails(productId: widget.productId,)),));
                return;
              }
              setState(() {
                isLoading = true;
              });
              await cartManager.addToCart(sku: product.sku??"", quantity: quantity);
              setState(() {
                isLoading = false;
              });
              navManager.updateNavIndex(3);
              Navigator.pop(context);
            },
            onContinue: (quantity) async {
              setState(() {
                isLoading = true;
              });
              await cartManager.addToCart(sku: product.sku??"", quantity: quantity);
              setState(() {
                isLoading = false;
              });
              navManager.updateNavIndex(0);
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.close, color: const Color(0xFF3B3A3A), size: 26.sp,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}


class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final Function(int) onCheckout;
  final Function(int) onContinue;
  const ProductItem({Key? key, required this.imageUrl, required this.title, required this.price, required this.onCheckout, required this.onContinue}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.sp),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              children: [
                Image.network(widget.imageUrl, width: 100.w, fit: BoxFit.fitWidth, errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error_outline, color: Colors.red,)),),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 30.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.title, style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                  Text('x$quantity', style: TextStyle(color: const Color(0xFF373737), fontFamily: 'DinRegular', fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(child: Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 10.h, right: 10.w),
                              child: Row(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText("RM", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                                      AutoSizeText(widget.price, maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                                      // AutoSizeText(widget.price.split('.').last, maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                              child: QuantityButton(value: quantity, onChange: (newQuantity) {
                                setState(() {
                                  quantity = newQuantity;
                                });
                              },),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Please Select Option', style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', fontSize: 16.sp),),
                Row(
                  children: [
                    optionButton(title: 'Option 1', onPressed: (){}),
                    optionButton(title: 'Option 2', onPressed: (){}),
                    optionButton(title: 'Option 3', onPressed: (){}),
                  ],
                ),

                SizedBox(height: 50.h,),
              ],
            ),
          ),


          checkoutButton(),
        ],
      ),
    );
  }

  Widget optionButton({required String title, required VoidCallback onPressed}){
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: TextButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinRegular', fontSize: 12.sp),),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }

  Widget checkoutButton(){
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: TextButton(
              child: Text('Continue Shopping', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
              onPressed: (){
                Navigator.pop(context);
                widget.onContinue(quantity);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.purplePrimary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: TextButton(
              child: Text('Checkout', style: TextStyle(fontSize: 17.sp, fontFamily: 'DinRegular', fontWeight: FontWeight.bold, color: Colors.white),),
              onPressed: (){
                Navigator.pop(context);
                widget.onCheckout(quantity);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.purpleSecondary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
              ),
            ),
          ),
        ),
      ],
    );
  }
}
