import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarouselView extends StatefulWidget {
  final List<Widget> slideItems;

  const ProductCarouselView({Key? key, required this.slideItems}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CarouselWithIndicatorState();
  }
}

class CarouselWithIndicatorState extends State<ProductCarouselView> {


  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  items: widget.slideItems,
                  options: CarouselOptions(
                      height: 300.h,
                      viewportFraction: 1.2,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _carouselController.previousPage(),
                      icon: _current > 0 ? Icon(Icons.arrow_back_ios_rounded, color: AppColors.greyIcon, size: 30.sp,) : const SizedBox(),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _carouselController.nextPage(),
                      icon: _current + 1 < widget.slideItems.length ? Icon(Icons.arrow_forward_ios_rounded, color: AppColors.greyIcon, size: 30.sp,) : const SizedBox(),
                    ),
                  ],
                ),
              ]
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text("${_current+1}/${widget.slideItems.length}", style: TextStyle(fontSize: 14.sp, color: Colors.grey[300]),),
            ),
          ),
        ],
      ),
    );
  }
}

