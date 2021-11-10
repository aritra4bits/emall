import 'package:emall/widgets/carousel_view.dart';
import 'package:flutter/material.dart';

class StoreTopBannerView extends StatelessWidget {
  const StoreTopBannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerCarouselView(
      slideItems: [
        Image.asset('assets/images/placeholders/top_banner.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/top_banner.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/top_banner.png', fit: BoxFit.fitHeight,),
        Image.asset('assets/images/placeholders/top_banner.png', fit: BoxFit.fitHeight,),
      ],
    );
  }
}