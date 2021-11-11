import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/cart_page_manager.dart';
import 'package:emall/managers/nav_bar_manager.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewAddressView extends StatefulWidget {
  const AddNewAddressView({Key? key}) : super(key: key);

  @override
  State<AddNewAddressView> createState() => _AddNewAddressViewState();
}

class _AddNewAddressViewState extends State<AddNewAddressView> {

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.sp),
            child: GreyRoundButton(onPressed: (){cartPageManager.updatePageIndex(1);}, icon: Icons.arrow_back_ios_rounded,),
          ),
          iconTheme: const IconThemeData(color: AppColors.textLightBlack),
          titleSpacing: 0,
          title: AutoSizeText('SHIPPING ADDRESS', style: TextStyle(color: AppColors.textLightBlack.withOpacity(0.7), fontWeight: FontWeight.w600),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              textFieldWithTitle(title: 'Email', textCapitalization: TextCapitalization.none, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('You can create an account after checkout.', style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w300, fontSize: 14.sp),),
              ),
              Divider(color: AppColors.textBlack, height: 70.h, thickness: 1.sp, indent: 20.w, endIndent: 20.w,),
              textFieldWithTitle(title: 'First Name', textCapitalization: TextCapitalization.words, textInputType: TextInputType.name, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'Last Name', textCapitalization: TextCapitalization.words, textInputType: TextInputType.name, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'Street Address', textCapitalization: TextCapitalization.words, textInputType: TextInputType.streetAddress, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'City', textCapitalization: TextCapitalization.words, textInputType: TextInputType.streetAddress, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'State', textCapitalization: TextCapitalization.words, textInputType: TextInputType.streetAddress, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'Zip/Postal Code', textCapitalization: TextCapitalization.none, textInputType: TextInputType.number, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'Country', textCapitalization: TextCapitalization.words, textInputType: TextInputType.name, textInputAction: TextInputAction.next),
              textFieldWithTitle(title: 'Phone Number', textCapitalization: TextCapitalization.none, textInputType: TextInputType.phone, textInputAction: TextInputAction.done),
              SizedBox(height: 20.h,),
              nextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWithTitle({required String title, TextEditingController? controller, FocusNode? focusNode, TextCapitalization? textCapitalization, TextInputAction? textInputAction, TextInputType? textInputType}){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: AppColors.textBlack, fontFamily: 'DinBold', fontSize: 14.sp),),
          TextFieldWidget(controller: controller, focusNode: focusNode, hintText: title, textCapitalization: textCapitalization??TextCapitalization.none, textInputAction: textInputAction, textInputType: textInputType,),
          SizedBox(height: 30.h,),
        ],
      ),
    );
  }

  Widget nextButton(){
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: TextButton(
              child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 17.sp, fontFamily: 'DinRegular'),),
              onPressed: (){
                cartPageManager.updatePageIndex(1);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.purpleSecondary),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
