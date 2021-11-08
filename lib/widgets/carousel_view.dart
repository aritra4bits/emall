import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarouselView extends StatefulWidget {
  final List<Widget> slideItems;

  const BannerCarouselView({Key? key, required this.slideItems}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CarouselWithIndicatorState();
  }
}

class CarouselWithIndicatorState extends State<BannerCarouselView> {


  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            items: widget.slideItems,
            options: CarouselOptions(
                height: 160.h,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          Positioned(
            bottom: -3.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.slideItems.map((url) {
                int index = widget.slideItems.indexOf(url);
                return Container(
                  width: ScreenUtil().setHeight(8),
                  height: ScreenUtil().setHeight(8),
                  margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(2)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                    color: _current == index
                        ? Colors.white
                        : Colors.transparent,
                  ),
                );
              }).toList(),
            ),
          ),
        ]
    );
  }
}

