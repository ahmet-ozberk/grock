import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  back([dynamic result]) => Navigator.pop(this, result);

  next(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));

  nextRemove(Widget page) => Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (BuildContext context) => page),
        (Route<dynamic> route) => false,
      );
}
