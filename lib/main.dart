import 'package:emall/screens/nav_view/nav_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 735),
      builder: () => MaterialApp(
        title: 'E-Mall',
        navigatorKey: globalKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'DinRegular'
        ),
        debugShowCheckedModeBanner: false,
        home: const NavBarView(),
      ),
    );
  }
}
