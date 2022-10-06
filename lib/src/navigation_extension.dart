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
  
  nextReplacement(Widget page) => Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (BuildContext context) => page),
      );

  nextNamed(String routeName) => Navigator.of(this).pushNamed(routeName);

  nextNamedRemove(String routeName) => Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (Route<dynamic> route) => false,
      );

  nextNamedReplacement(String routeName) => Navigator.pushReplacementNamed(
        this,
        routeName,
      );

  nextNamedAndRemoveUntil(String routeName, RoutePredicate predicate) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, predicate);

  nextAndRemoveUntil(Widget page, RoutePredicate predicate) =>
      Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (BuildContext context) => page),
        predicate,
      );

  nextAndRemoveUntilNamed(String routeName, RoutePredicate predicate) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, predicate);
}
