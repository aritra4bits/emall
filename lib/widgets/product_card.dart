import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String productImageUrl;
  final String productTitle;
  final String discountPrice;
  final String actualPrice;
  final double rating;
  final int? reviewsCount;
  final double? discount;
  const ProductCard(
      {Key? key,
      required this.productId,
      required this.productImageUrl,
      required this.productTitle,
      required this.discountPrice,
      required this.actualPrice,
      required this.rating,
      this.reviewsCount, this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productId: productId,),));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h,),
                Expanded(flex: 4, child: Image.network(productImageUrl, fit: BoxFit.fitHeight,)),
                const Spacer(flex: 1,),
                Row(
                  children: [
                    Flexible(child: Text(productTitle, maxLines: 2, style: TextStyle(fontSize: 13.sp),)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("RM", maxLines: 1, maxFontSize: 14.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 14.sp, color: AppColors.productPrice),),
                        AutoSizeText(discountPrice.split('.').first + '.', maxLines: 1, maxFontSize: 20.sp, minFontSize: 14.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 20.sp, color: AppColors.productPrice),),
                        AutoSizeText(discountPrice.split('.').last, maxLines: 1, maxFontSize: 14.sp, minFontSize: 12.sp, stepGranularity: 1.sp, style: TextStyle(fontSize: 14.sp, color: AppColors.productPrice),),
                      ],
                    ),
                    SizedBox(width: 5.w,),
                    Flexible(
                      child: AutoSizeText(
                        actualPrice,
                        maxLines: 1, maxFontSize: 12.sp, minFontSize: 10.sp, stepGranularity: 1.sp,
                        style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    reviewsCount != null ? Text("($reviewsCount)") : const SizedBox(),
                  ],
                )
              ],
            ),
            discount != null ? Positioned(
              right: -15.w,
              child: Container(
                color: AppColors.productPrice,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Text('${discount?.round()}%', style: TextStyle(color: Colors.white, fontSize: 12.sp),),
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
