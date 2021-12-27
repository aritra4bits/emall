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

  final ScrollController _scrollController = ScrollController();
  bool hasNextPage = false;
  bool isLoadingProducts = false;
  bool wasAddedToList = false;
  int pageSize = 6;
  int currentPage = 1;
  List<CategoryProductItem> productItems = [];

  @override
  void initState() {
    super.initState();
    categoryListManager.getProductsInCategory(categoryId: widget.categoryId, pageSize: pageSize.toString(), currentPage: currentPage.toString());
    currentPage++;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if(_scrollController.hasClients) {
        _scrollController.addListener(() async {
          if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
              !_scrollController.position.outOfRange) {
            print("Reached bottom");
            if(hasNextPage){
              setState(() {
                isLoadingProducts = true;
              });
              await categoryListManager.getProductsInCategory(categoryId: widget.categoryId, pageSize: pageSize.toString(), currentPage: currentPage.toString(), withLoading: false);
              wasAddedToList = false;
              setState(() {
                isLoadingProducts = false;
              });
              hasNextPage = false;
              currentPage++;
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() { });
    _scrollController.dispose();
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: 15.w),
          //   sliver: SliverList(
          //     delegate: SliverChildListDelegate(
          //       [
          //         Text('STORES', style: TextStyle(fontSize: 16.sp, color: AppColors.textLightBlack, fontFamily: 'DinBold'),),
          //         SizedBox(height: 10.h,),
          //         storeNameSection(context: context, title: 'SONY STORE'),
          //         SizedBox(height: 40.h,),
          //         storeDetails(),
          //         SizedBox(height: 30.h,),
          //
          //       ]
          //     ),
          //   ),
          // ),
          productsInCategory(),
        ],
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
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      sliver: StreamBuilder<ApiResponse<ProductsInCategoryModel>?>(
          stream: categoryListManager.productsInCategory,
          builder: (BuildContext context, AsyncSnapshot<ApiResponse<ProductsInCategoryModel>?> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return SliverToBoxAdapter(child: SizedBox(height: 200.sp, child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),))));
                case Status.COMPLETED:
                  if(snapshot.data?.data?.items != null && snapshot.data!.data!.items!.length >= pageSize){
                    hasNextPage = true;
                  }else{
                    hasNextPage = false;
                  }
                  if(!wasAddedToList && snapshot.data?.data?.items != null){
                    productItems.addAll(snapshot.data!.data!.items!);
                    wasAddedToList = true;
                  }
                  productItems.toSet().toList();
                  return productsInCategoryView(snapshot.data?.data?.items??[]);
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

  Widget productsInCategoryView(List<CategoryProductItem> products) {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.75),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if(index == productItems.length){
              if(isLoadingProducts){
                return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),
                    ));
              }else{
                return const SizedBox();
              }
            }
            int specialPriceIndex = productItems[index].customAttributes!.indexWhere((element) => element.attributeCode == "special_price");
            return ProductCard(productId: "${productItems[index].id}", productImageUrl: productItems[index].mediaGalleryEntries != null && productItems[index].mediaGalleryEntries!.isNotEmpty ? "https://mage2.fireworksmedia.com/pub/media/catalog/product${productItems[index].mediaGalleryEntries?.first.file}" : "", productTitle: productItems[index].name!, discountPrice: specialPriceIndex >= 0 ? productItems[index].customAttributes![specialPriceIndex].value : "", actualPrice: "${productItems[index].price?.toStringAsFixed(2)}", rating: 4.4, reviewsCount: 5);
          },
          childCount: productItems.length+1,
        ),
    );
  }
}
