import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/screens/auth/login.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterUserView extends StatefulWidget {
  final Widget? targetView;
  const RegisterUserView({Key? key, required this.targetView}) : super(key: key);

  @override
  _RegisterUserViewState createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purplePrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register", style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 40.sp,),
            TextFieldWidget(
              controller: firstNameController,
              hintText: "Enter first name",
              textInputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            TextFieldWidget(
              controller: lastNameController,
              hintText: "Enter last name",
              textInputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            TextFieldWidget(
              controller: emailController,
              hintText: "Enter email address",
              textInputType: TextInputType.emailAddress,
            ),
            TextFieldWidget(
              controller: passwordController,
              hintText: "Enter password",
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
            ),
            TextFieldWidget(
              controller: confirmPasswordController,
              hintText: "Confirm password",
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 40.sp,),
            SizedBox(
              height: 40.h,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: () async {
                    if(firstNameController.text.isEmpty){
                      AppUtils.showToast("Enter first name");
                    } else if(lastNameController.text.isEmpty){
                      AppUtils.showToast("Enter last name");
                    } else if(emailController.text.isEmpty){
                      AppUtils.showToast("Enter valid email");
                    } else if(passwordController.text.isEmpty){
                      AppUtils.showToast("Enter password");
                    } else if(confirmPasswordController.text.isEmpty){
                      AppUtils.showToast("Enter confirm password");
                    } else if(passwordController.text != confirmPasswordController.text){
                      AppUtils.showToast("Passwords don't match");
                    } else{
                      Map params = {
                        "customer" : {
                          "firstname" : firstNameController.text,
                          "lastname" : lastNameController.text,
                          "email" : emailController.text
                        },
                        "password" : passwordController.text
                      };
                      bool? success = await authManager.registerUser(params: params);
                      if(success == true){
                        if(widget.targetView != null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUserView(targetView: widget.targetView!),));
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginUserView(targetView: null),));
                        }
                      }
                    }
                  },
                  child: Text("Register", style: TextStyle(fontSize: 20.sp),),
                ),
              ),
            ),
            SizedBox(height: 20.sp,),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUserView(targetView: widget.targetView,),));
              },
              child: Text("Already have an account? Login", style: TextStyle(color: Colors.white, fontSize: 16.sp),),
            ),
          ],
        ),
      ),
    );
  }
}
