// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/widgets/widget_image.dart';
import 'package:leaveworkung/widgets/widget_text.dart';
import 'package:leaveworkung/widgets/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog(
      {required String title, Widget? contentWidget, Widget? actionWidget}) {
    Get.dialog(
      AlertDialog(
        icon: const WidgetImage(
          size: 120,
        ),
        title: WidgetText(text: title, textStyle: AppConstant().h2Style(),),
        content: contentWidget,
        actions: [
          actionWidget ??
              WidgetTextButton(
                label: 'Cancel',
                pressFunc: () {
                  Get.back();
                },
              )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
