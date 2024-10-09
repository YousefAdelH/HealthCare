import 'dart:io';

import 'package:dental_app/features/home/widget/home_view.dart';
import 'package:dental_app/features/home/widget_mobile/home_view.dart';
import 'package:dental_app/features/main/mobile_widget/main_mobile.dart';
import 'package:dental_app/features/main/widget/main_view.dart';
import 'package:dental_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCtrl extends GetxController {
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool hidePass = true;

  changehidePass() {
    hidePass = !hidePass;
    update();
  }

  Future<void> authLogin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      // Checking if the user is successfully signed in
      if (userCredential.user != null) {
        Get.snackbar('Success', 'Login successful!',
            snackPosition: SnackPosition.BOTTOM);

        bool isDeviceRegistered = prefs.getBool('isDeviceRegistered') ?? false;

        if (!isDeviceRegistered) {
          // If device is not registered, mark it as registered
          await prefs.setBool('isDeviceRegistered', true);
        }
        controllerPassword.clear();
        controllerEmail.clear();
        if (Platform.isAndroid || Platform.isIOS) {
          Get.offAll(() => HomeViewMobile());
        } else {
          Get.offAll(() => HomeView());
        }
      } else {
        // Handling case where user is null (should not happen with correct credentials)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Unexpected error occurred. Please try again.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await auth.signOut();
    await prefs.setBool('isDeviceRegistered', false);
    if (Platform.isAndroid || Platform.isIOS) {
      Get.offAll(() => MainViewMobile());
    } else {
      Get.offAll(() => MainView());
    }
  }
}
