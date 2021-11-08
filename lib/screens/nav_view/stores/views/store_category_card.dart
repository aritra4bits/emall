import 'package:emall/screens/nav_view/stores/category_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const StoreCategoryCard({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailsPage(titleBarText: title),));
      },
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image.asset('assets/images/placeholders/$imageUrl', fit: BoxFit.fitHeight,)),
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
