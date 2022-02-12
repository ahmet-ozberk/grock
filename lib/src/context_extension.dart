import 'package:flutter/material.dart';
import 'int_extension.dart';

extension SizeExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => MediaQuery.of(this).size;
  double get top => MediaQuery.of(this).padding.top;
  double get bottom => MediaQuery.of(this).padding.bottom;
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  TextStyle get body1 => Theme.of(this).textTheme.bodyText1!;
  TextStyle get body2 => Theme.of(this).textTheme.bodyText2!;
  TextStyle get headline1 => Theme.of(this).textTheme.headline1!;
  TextStyle get headline2 => Theme.of(this).textTheme.headline2!;
}

extension ColorExtension on BuildContext {
  Color get randomColor => Colors.primaries[17.randomNum];
}
