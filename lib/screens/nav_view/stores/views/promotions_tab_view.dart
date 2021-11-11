import 'package:emall/screens/nav_view/stores/widgets/filter_widget.dart';
import 'package:emall/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromotionsTabView extends StatefulWidget {
  const PromotionsTabView({Key? key}) : super(key: key);

  @override
  State<PromotionsTabView> createState() => _PromotionsTabViewState();
}

class _PromotionsTabViewState extends State<PromotionsTabView> {

  String value = 'Popularity';

  List onSaleProductItems = [
    ["ps4.png", "Sony PlayStation 4 Mega Pack 2", "1099.90", "", 5.0, 24, 20.0],
    ["router.png", "TP-LINK 5Ghz + 2.4GHz AC600 Mini...", "199.80", "799.80", 4.0, 214, 30.0],
    ["laptop.png", 'MacBook 13"2018', "3999.90", "", 5.0, 24, 25.0],
    ["hdtv.png", 'Samsung 32"TV', "599.80", "", 4.0, 214, 15.0],
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          StoreFilterWidget(
            value: value,
            onChanged: (val){
              if(val != null){
                setState(() {
                  value = val;
                });
              }
            },
          ),
          GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: onSaleProductItems.length,
              itemBuilder: (BuildContext ctx, index) {
                return ProductCard(
                  productImageUrl: onSaleProductItems[index][0],
                  productTitle: onSaleProductItems[index][1],
                  discountPrice: onSaleProductItems[index][2],
                  actualPrice: onSaleProductItems[index][3],
                  rating: onSaleProductItems[index][4],
                  // reviewsCount: onSaleProductItems[index][5],
                  discount: onSaleProductItems[index][6],
                );
              }),

          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}
