import 'package:flutter/material.dart';
import 'package:grock/src/int_extension.dart';

extension SizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get top => MediaQuery.of(this).padding.top;
  double get bottom => MediaQuery.of(this).padding.bottom;
  double get width => size.width;
  double get height => size.width;
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
}

extension ColorExtension on BuildContext {
  Color get randomColor => Colors.primaries[17.randomNum];
}
