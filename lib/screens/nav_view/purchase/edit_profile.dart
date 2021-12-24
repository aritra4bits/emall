import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/dropdown_select_button.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  int? selectedGender;
  bool isLoading = false;

  List<String> genders = [
    "Not selected",
    "Male",
    "Female",
    "Other"
  ];


  @override
  void initState() {
    super.initState();
    setUserDetails();
  }

  setUserDetails() async {
    Customer? userDetails = authManager.getUserDetails();
    if (userDetails != null) {
      emailController.text = userDetails.email!;
      firstNameController.text = userDetails.firstname!;
      lastNameController.text = userDetails.lastname!;
      selectedGender = userDetails.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Container(
        color: AppColors.purplePrimary.withOpacity(0.3),
        alignment: Alignment.center,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: [AppColors.purplePrimary],
        ),
      ),
      child: KeyboardDismissWrapper(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.sp),
              child: GreyRoundButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icons.arrow_back_ios_rounded,
              ),
            ),
            iconTheme: const IconThemeData(color: AppColors.textLightBlack),
            titleSpacing: 0,
            title: AutoSizeText(
              'EDIT PROFILE',
              style: TextStyle(
                  color: AppColors.textLightBlack.withOpacity(0.7),
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: Stack(
            children: [
              SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      textFieldWithTitle(title: 'Email', controller: emailController, textCapitalization: TextCapitalization.none, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'First Name',
                          controller: firstNameController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'Last Name',
                          controller: lastNameController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next),
                      genderSelector(title: "Gender"),
                      SizedBox(height: 54.h,),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: saveButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWithTitle(
      {required String title,
        TextEditingController? controller,
        FocusNode? focusNode,
        TextCapitalization? textCapitalization,
        TextInputAction? textInputAction,
        TextInputType? textInputType}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontSize: 14.sp),
          ),
          TextFieldWidget(
            controller: controller,
            focusNode: focusNode,
            hintText: title,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textInputAction: textInputAction,
            textInputType: textInputType,
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget genderSelector(
      {required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontSize: 14.sp),
          ),
          DropdownSelectButton(
            hintText: title,
            items: genders,
            value: genders[selectedGender??0],
            onChanged: (gender) {
              setState(() {
                selectedGender = genders.indexWhere((element) => element == gender);
              });
            },
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: TextButton(
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontFamily: 'DinRegular'),
              ),
              onPressed: () async {
                if(emailController.text.isEmpty){
                  AppUtils.showToast("Please enter a valid email");
                } else if (firstNameController.text.isEmpty) {
                  AppUtils.showToast("Please enter your first name");
                } else if (lastNameController.text.isEmpty) {
                  AppUtils.showToast("Please enter your last name");
                } else {
                  Customer? userDetails = authManager.getUserDetails();
                  Map params = {
                    "customer": {
                      "email": emailController.text,
                      "firstname": firstNameController.text,
                      "lastname": lastNameController.text,
                      "gender": selectedGender,
                      "addresses": userDetails?.addresses != null ? List<dynamic>.from(userDetails!.addresses!.map((x) => x.toJson())) : []
                    }
                  };
                  setState(() {
                    isLoading = true;
                  });
                  await authManager.updateUser(params: params, withLoading: false);
                  Customer? user = authManager.getUserDetails();
                  emailController.text = user?.email??"";
                  firstNameController.text = user?.firstname??"";
                  lastNameController.text = user?.lastname??"";
                  selectedGender = user?.gender??0;
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(AppColors.purpleSecondary),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
