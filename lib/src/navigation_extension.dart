import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  back() => Navigator.of(this).pop();
  
  next({required Widget page}) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));

  nextRemove({required Widget page}) => Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (BuildContext context) => page),
      (Route<dynamic> route) => false);
}
