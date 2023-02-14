import 'package:flutter/material.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/widgets/widget_image.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class WidgetLogo extends StatelessWidget {
  const WidgetLogo({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const WidgetImage(
              size: 48,
            ),
            WidgetText(
              text: AppConstant.appName,
              textStyle: AppConstant().h2Style(size: 12),
            )
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        WidgetText(
          text: title,
          textStyle: AppConstant().h1Style(),
        )
      ],
    );
  }
}
