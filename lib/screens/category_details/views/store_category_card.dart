import 'package:emall/constants/colors.dart';
import 'package:emall/managers/category_manager/category_manager.dart';
import 'package:emall/models/product_categories/category_details_model.dart';
import 'package:emall/screens/category_details/category_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreCategoryCard extends StatelessWidget {
  final String categoryId;
  final String title;
  const StoreCategoryCard({Key? key, required this.title, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailsPage(titleBarText: title, categoryId: categoryId,),));
      },
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(8.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FutureBuilder<CategoryDetailsModel?>(
                  future: categoryListManager.getCategoryDetails(categoryId: categoryId),
                  builder: (BuildContext context, AsyncSnapshot<CategoryDetailsModel?> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.purplePrimary),));
                    } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null){
                      int imageAttributeIndex = snapshot.data!.customAttributes!.indexWhere((element) => element.attributeCode == "image");
                      if(imageAttributeIndex > -1){
                        return Image.network("https://mage2.fireworksmedia.com${snapshot.data!.customAttributes![imageAttributeIndex].value}", fit: BoxFit.fitHeight,);
                      } else {
                        return const Center(
                          child: Icon(Icons.image_not_supported, color: AppColors.purplePrimary,),
                        );
                      }
                    }
                    return Container();
                  }
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF373737)),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
