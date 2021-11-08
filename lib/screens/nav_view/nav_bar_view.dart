import 'package:emall/constants/colors.dart';
import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/screens/misc/network_error_view.dart';
import 'package:emall/screens/nav_view/stores/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dashboard/dashboard_screen.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {

  int _tabIndex = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      const DashboardView(),
      Container(),
      const StoreView(),
      Container(),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.purplePrimary),
        ),
        inAsyncCall: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
              onWillPop: () async => false,
              child: OfflineBuilder(
                  connectivityBuilder: (
                      BuildContext context,
                      ConnectivityResult connectivity,
                      Widget child,
                      ) {
                    if (connectivity == ConnectivityResult.none) {
                      return const Scaffold(
                        body: Center(child: NetworkErrorPage()),
                      );
                    }
                    return child;
                  },
                  child: bottomNavigation(context)),
            )));
  }

  Widget bottomNavigation(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int?>(
          stream: navManager.navIndexStream,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data != null){
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                setState(() {
                  _tabIndex = snapshot.data!;
                });
                navManager.reset();
              });
            }
            return _children[_tabIndex];
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        backgroundColor: AppColors.purplePrimary,
        selectedItemColor: Colors.white,
        iconSize: 24.sp,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(11), fontFamily: "AppLight"),
        unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(11), fontFamily: "AppLight"),
        onTap: (value) async {
          setState(() {
            _tabIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset('assets/images/icons/home.png', height: 24.sp, color: _tabIndex == 0 ? Colors.white : Colors.white,),
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset('assets/images/icons/search.png', height: 24.sp, color: _tabIndex == 1 ? Colors.white : Colors.white,),
            ),
          ),
          BottomNavigationBarItem(
            label: "Stores",
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset('assets/images/icons/stores.png', height: 24.sp, color: _tabIndex == 2 ? Colors.white : Colors.white,),
            ),
          ),
          BottomNavigationBarItem(
            label:"My Cart",
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset('assets/images/icons/my_cart.png', height: 24.sp, color: _tabIndex == 3 ? Colors.white : Colors.white,),
            ),
          ),
          BottomNavigationBarItem(
            label: "My Purchase",
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset('assets/images/icons/my_purchase.png', height: 24.sp, color: _tabIndex == 4 ? Colors.white : Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
