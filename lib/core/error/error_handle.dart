import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ErrorHandler {
  static void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void logError(String message,
      [dynamic error, StackTrace? stackTrace]) {
    // Log error to an external service or console
    print("Error: $message");
    if (error != null) {
      print("Exception: $error");
    }
    if (stackTrace != null) {
      print("StackTrace: $stackTrace");
    }
  }
}
