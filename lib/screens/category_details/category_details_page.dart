import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/category_manager/category_manager.dart';
import 'package:emall/models/product_categories/products_in_category.dart';
import 'package:emall/screens/nav_view/stores/views/store_details_view.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailsPage extends StatefulWidget {
  final String categoryId;
  final String titleBarText;
  const CategoryDetailsPage({Key? key, required this.titleBarText, required this.categoryId}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();

  static const List storeDetailsItems = [
    'Lorem ipsum dolor sit amet', 'Nulla facilisis dui id justo', 'Donec et magna', 'Nulla pretium ex'
  ];
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {

  @override
  void initState() {
    super.initState();
    categoryListManager.getProductsInCategory(categoryId: widget.categoryId, pageSize: "10", currentPage: "1");
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
        iconTheme: const IconThemeData(color: AppColors.textLightBlack),
        titleSpacing: 0,
        title: AutoSizeText(widget.titleBarText.toUpperCase(), style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
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
            SizedBox(height: 30.h,),
            productsInCategory(),
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

  Widget storeDetails() {
    return ListView.builder(
      itemCount: CategoryDetailsPage.storeDetailsItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        padding: EdgeInsets.all(15.sp),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Text(CategoryDetailsPage.storeDetailsItems[index], style: TextStyle(fontSize: 13.sp, color: const Color(0xFF6C6C6C), fontWeight: FontWeight.w600),),
      ),
    );
  }

  Widget productsInCategory(){
    return StreamBuilder<ApiResponse<ProductsInCategoryModel>?>(
        stream: categoryListManager.productsInCategory,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductsInCategoryModel>?> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return SizedBox(height: 200.sp, child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),)));
              case Status.COMPLETED:
                return productsInCategoryView(snapshot.data?.data?.items??[]);
              case Status.NODATAFOUND:
                return const SizedBox();
              case Status.ERROR:
                return const SizedBox();
            }
          }
          return Container();
        }
    );
  }

  Widget productsInCategoryView(List<CategoryProductItem> products) {
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
          int specialPriceIndex = products[index].customAttributes!.indexWhere((element) => element.attributeCode == "special_price");
          return ProductCard(productId: "${products[index].id}", productImageUrl: products[index].mediaGalleryEntries != null && products[index].mediaGalleryEntries!.isNotEmpty ? "https://mage2.fireworksmedia.com/pub/media/catalog/product${products[index].mediaGalleryEntries?.first.file}" : "", productTitle: products[index].name!, discountPrice: specialPriceIndex >= 0 ? products[index].customAttributes![specialPriceIndex].value : "", actualPrice: "${products[index].price?.toStringAsFixed(2)}", rating: 4.4, reviewsCount: 5);
        });
  }
}
