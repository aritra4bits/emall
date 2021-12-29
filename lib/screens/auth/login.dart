import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/screens/auth/register.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginUserView extends StatefulWidget {
  final Widget? targetView;
  const LoginUserView({Key? key, required this.targetView}) : super(key: key);

  @override
  _LoginUserViewState createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  bool isLoading = false;

  unFocus(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
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
      child: Scaffold(
        backgroundColor: AppColors.purplePrimary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 40.sp,),
              TextFieldWidget(
                controller: emailController,
                focusNode: emailFocusNode,
                hintText: "Enter email address",
                textInputType: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                controller: passwordController,
                hintText: "Enter password",
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      if(emailController.text.isNotEmpty){
                        unFocus(context);
                        Map params = {
                          "email": emailController.text,
                          "template": "email_reset"
                        };
                        setState(() {
                          isLoading = true;
                        });
                        bool? response = await authManager.resetPassword(params: params);
                        setState(() {
                          isLoading = false;
                        });
                        if(response == true){
                          AppUtils.showToast("Password reset link send to your email address");
                        } else {
                          AppUtils.showToast("Failed to send password reset link to this email address");
                        }
                      } else {
                        AppUtils.showToast("Please enter a valid email address");
                        emailFocusNode.requestFocus();
                      }
                    },
                    child: Text("Forgot password?", style: TextStyle(color: Colors.white, fontSize: 16.sp),),
                  )
                ],
              ),
              SizedBox(height: 40.sp,),
              SizedBox(
                height: 40.h,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(emailController.text.isEmpty){
                        AppUtils.showToast("Enter valid email");
                      } else if(passwordController.text.isEmpty){
                        AppUtils.showToast("Enter password");
                      } else{
                        Map params = {
                          "username": emailController.text,
                          "password": passwordController.text
                        };
                        setState(() {
                          isLoading = true;
                        });
                        bool? success = await authManager.loginUser(params: params);
                        setState(() {
                          isLoading = false;
                        });
                        if(success == true){
                          if(widget.targetView != null){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.targetView!,));
                          } else {
                            Navigator.pop(context, true);
                          }
                        } else {
                          AppUtils.showToast("Login failed!");
                        }
                      }
                    },
                    child: Text("Login", style: TextStyle(fontSize: 20.sp),),
                  ),
                ),
              ),
              SizedBox(height: 20.sp,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterUserView(targetView: widget.targetView,),));
                },
                child: Text("Don't have an account? Register", style: TextStyle(color: Colors.white, fontSize: 16.sp),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
