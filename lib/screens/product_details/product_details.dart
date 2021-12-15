import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/product_details_manager/product_details_manager.dart';
import 'package:emall/managers/products_listing_manager/products_listing_manager.dart';
import 'package:emall/managers/ui_manager/nav_bar_manager.dart';
import 'package:emall/models/product_model/product_model.dart';
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

  int productQuantity = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    productDetailsManager.getProducts(productId: widget.productId);
    productsListingManager.getOnSaleProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ApiResponse<ProductModel>?>(
          stream: productsListingManager.onSaleProductList,
          builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductModel>?> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
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
            child: Column(
              children: [
                productCarouselView(product),
                SizedBox(height: 10.h,),
                productPriceDetailsCard(product),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    openBottomSheet(context, detailsBottomSheet(context));
                  },
                  child: productDetailsCard(title: 'Product Details > ',
                      description: product.customAttributes![product.customAttributes!.indexWhere((element) => element.attributeCode == "short_description")].value),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    openBottomSheet(context, specsBottomSheet(context));
                  },
                  child: productDetailsCard(title: 'Specifications > ',
                      description: product.customAttributes![product.customAttributes!.indexWhere((element) => element.attributeCode == "description")].value),
                ),
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

  Widget productCarouselView(Item product) {
    return ProductCarouselView(
      slideItems: product.mediaGalleryEntries!.map((e) => Image.network("https://mage2.fireworksmedia.com/pub/media/catalog/product${e.file}")).toList(),
    );
  }

  Widget productPriceDetailsCard(Item product) {
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
                  AutoSizeText("${product.price}", maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                  // AutoSizeText("50", maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
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
          Text(description, style: TextStyle(fontSize: 12.sp),)
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
          return ProductCard(productId: "", productImageUrl: recommendedProductItems[index][0], productTitle: recommendedProductItems[index][1], discountPrice: recommendedProductItems[index][2], actualPrice: recommendedProductItems[index][3], rating: recommendedProductItems[index][4], reviewsCount: recommendedProductItems[index][5]);
        });
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

  Widget addToCartButton() {
    return Row(
      children: [
        Material(
          color: Colors.white,
          child: Container(
            alignment: Alignment.center,
            height: 60.h,
            width: 80.w,
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreDetailsView(),));
              },
              padding: EdgeInsets.zero,
              icon: Image.asset('assets/images/icons/stores.png', color: Colors.black, height: 30, fit: BoxFit.fitHeight,),
            ),
          ),
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
              onPressed: (){
                openBottomSheet(context, addToCart(context));
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

  Widget detailsBottomSheet(BuildContext context){
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
"""PRODUCT DETAILS

Product Title: Sony PlayStation 4 Mega Pack 2

What's in the box: PlayStation 4 (Jet Black) with 1TB HDD x 1 (CUH-2218BB01)

DUALSHOCK 4 wireless controller (Jet Black) x 1

PS4 title “God of War™” (Traditional Chinese / English Ver.) Disc version x 1

PS4 title “Horizon Zero Dawn™: Complete Edition” (Traditional Chinese / English Ver.) Disc version x 1

PS4 title "Grand Theft Auto V Premium Edition" (English / Chinese Ver.) Disc version x 1

PS4 title "FORTNITE NEO VERSA BUNDLE" (English / Chinese Ver.) Digital version x 1

PlayStation Plus 3-month subscription x 1""",
                style: TextStyle(color: const Color(0xFF3B3A3A), fontSize: 15.sp, fontFamily: 'DinRegular'),
              )
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

  Widget specsBottomSheet(BuildContext context){
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
"""SPECIFICATIONS

Sony PlayStation 4 Mega Pack 2

Brand: Sony

SKU: 664162577_MY-1423020668

Warranty Period: 1 Year

Console Type: Playstation

Warranty Type: Local Manufacturer Warranty

Internal Memory: 1TB

Console Model: PS4

What’s in the box:
PlayStation 4 (Jet Black) with 1TB HDD,
DUALSHOCK 4 wireless controller (Jet Black) x 1,
PS4 title “God of War™” Disc version""",
                style: TextStyle(color: const Color(0xFF3B3A3A), fontSize: 15.sp, fontFamily: 'DinRegular'),
              )
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

  Widget addToCart(BuildContext context){
    return Stack(
      children: [
        SingleChildScrollView(
          child: ProductItem(
            imageUrl: 'assets/images/placeholders/ps4.png',
            title: 'Sony PlayStation 4 Mega Pack 2',
            price: '1999.50',
            onCheckout: (){
              navManager.updateNavIndex(3);
              Navigator.pop(context);
            },
            onContinue: (){
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
  final VoidCallback onCheckout;
  final VoidCallback onContinue;
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
                Image.asset(widget.imageUrl, width: 100.w, fit: BoxFit.fitWidth,),
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
                                      AutoSizeText('${widget.price.split('.').first}.', maxLines: 1, maxFontSize: 26.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 26.sp, color: AppColors.productPrice),),
                                      AutoSizeText(widget.price.split('.').last, maxLines: 1, maxFontSize: 16.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 16.sp, color: AppColors.productPrice),),
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
                widget.onContinue();
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
                widget.onCheckout();
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
