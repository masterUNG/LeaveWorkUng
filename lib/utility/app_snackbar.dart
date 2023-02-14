import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  void normalSnackbar({required String title, required String detail}) {
    Get.snackbar(
      title,
      detail,
      backgroundColor: Colors.orange,
    );
  }
}
