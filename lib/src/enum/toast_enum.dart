import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ToastTheme {
  dark(CupertinoColors.darkBackgroundGray, Colors.white),
  light(Color(0xFFEEEEEE), Colors.black);

  final Color bgColor;
  final Color fgColor;
  const ToastTheme(this.bgColor, this.fgColor);

  Color get backgroundColor => bgColor;
  Color get textColor => fgColor;
}
