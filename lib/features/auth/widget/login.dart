import 'package:dental_app/common/button_large.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/features/auth/controller/auth_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool isMobile() {
      // Example condition: consider mobile if screen width is less than 600
      return MediaQuery.of(context).size.width < 600;
    }

    return GetBuilder<AuthCtrl>(
        init: AuthCtrl(),
        builder: (con) {
          return SizedBox(
            width: isMobile()
                ? MediaQuery.of(context).size.width / 1.2
                : MediaQuery.of(context).size.width / 4,
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      radius: 10.r,
                      prefixIconPath: const Icon(Icons.person_outline),
                      textInputType: TextInputType.emailAddress,
                      label: S.of(context).email,
                      controller: con.controllerEmail,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pleaseEnteremail;
                        } else if (!(value.contains('@') &&
                            value.contains('@'))) {
                          return AppStrings.invalidemail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      radius: 10.r,
                      prefixIconPath: const Icon(Icons.password_outlined),
                      textInputType: TextInputType.emailAddress,
                      label: S.of(context).password,
                      controller: con.controllerPassword,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pleaseEnterpassword;
                        }
                        return null;
                      },
                      suffix: GestureDetector(
                        onTap: con.changehidePass,
                        child: Icon(
                          con.hidePass
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      isPassword: con.hidePass,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomLargeButton(
                      text: S.of(context).login,
                      backColor: Colors.blue,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print(con.controllerEmail.text);
                          print(con.controllerPassword.text);
                          con.authLogin(context);
                        }
                      },
                    )
                    // CustomLargeButton(
                    //   text: "Login",
                    //   backColor: AppColors.primary,
                    //   onPressed:
                    //     con.authlogin(context);

                    // )
                    // SizedBox(
                    //   child: const Text(
                    //     "Login",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
