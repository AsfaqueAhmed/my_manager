import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toaster {
  static error(String message) => Get.snackbar(
        "Error",
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
}
