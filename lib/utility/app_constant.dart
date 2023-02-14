import 'package:flutter/material.dart';

class AppConstant {
  static String appName = 'AMARIN\n  Group';
  static Color activeColor = Color.fromARGB(255, 156, 155, 223);

  TextStyle h1Style({double? size, Color? color}) {
    return TextStyle(
      fontSize: size ?? 36,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  TextStyle h2Style({double? size, Color? color}) {
    return TextStyle(
      fontSize: size ?? 20,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  TextStyle h3Style({double? size, Color? color}) {
    return TextStyle(
      fontSize: size ?? 14,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }
}
