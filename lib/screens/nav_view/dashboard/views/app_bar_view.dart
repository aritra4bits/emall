import 'dart:io';

import 'package:emall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarView extends StatefulWidget {
  final TextEditingController? searchController;
  final FocusNode? focusNode;
  const AppBarView({Key? key, this.searchController, this.focusNode}) : super(key: key);

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {

  static const methodChannel = MethodChannel('emall/data');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purplePrimary, AppColors.purpleSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("E-MALL", style: TextStyle(fontWeight: FontWeight.w300),),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
                if(Platform.isIOS){
                  methodChannel.invokeMethod('close');
                }else{
                  SystemNavigator.pop();
                }
              }, icon: Icon(Icons.close, size: 28.sp,)),
            ],
          ),
          searchBar(context),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.sp),
      padding: EdgeInsets.only(left: 15.w, right: 1.w, top: 1.h, bottom: 1.h),
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(6.sp),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.searchController,
              focusNode: widget.focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (value){
                if(value != '') {

                }
              },
              onChanged: (value) {

              },
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18.sp, color: Colors.white54),
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.white, size: 26.sp,),)
        ],
      ),
    );
  }
}
