import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future to(Widget page) {
    return navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => page));
  }

  static Future toRemove(Widget page) {
    return navigationKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static void back() {
    return navigationKey.currentState!.pop();
  }
}
