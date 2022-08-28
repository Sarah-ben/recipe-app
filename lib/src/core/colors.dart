import 'package:flutter/material.dart';

class AppColors {
  static primaryAppColor() =>
      Colors.red.withOpacity(.07);
  static secondaryAppColor() =>
      Colors.deepOrange;
  static primaryTextColor({double opacity = 1}) =>
      Color(0xFF111111).withOpacity(opacity);
  static secondaryTextColor({double opacity = 1}) =>
      Colors.purple;
  static primaryColor({double opacity = 1}) =>
      Color(0xFFFFFFFF).withOpacity(opacity);
  static secondaryColor({double opacity = 1}) =>
      Color(0xFFEEEEEE).withOpacity(opacity);
  static primaryWidgetColor() =>
      Color.fromRGBO(245, 230, 83, 1);
  static rateColor() =>
      Color.fromRGBO(245, 230, 83, 1);
}
