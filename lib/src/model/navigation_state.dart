import 'package:flutter/material.dart';
import 'package:grock/src/enum/nav_type.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future to(Widget page, {NavType? type}) {
    return navigationKey.currentState!.push(type != null
        ? PageTransition(type: _type(type), child: page)
        : MaterialPageRoute(builder: (context) => page));
  }

  static Future toRemove(Widget page, {NavType? type}) {
    return navigationKey.currentState!.pushAndRemoveUntil(
        type != null
            ? PageTransition(type: _type(type), child: page)
            : MaterialPageRoute(builder: (context) => page),
        (route) => false);
  }

  static void back({Object? result}) {
    return navigationKey.currentState!.pop(result);
  }

  



  static PageTransitionType _type(NavType type) {
    switch (type) {
      case NavType.fade:
        return PageTransitionType.fade;
      case NavType.rightToLeft:
        return PageTransitionType.rightToLeft;
      case NavType.leftToRight:
        return PageTransitionType.leftToRight;
      case NavType.topToBottom:
        return PageTransitionType.topToBottom;
      case NavType.bottomToTop:
        return PageTransitionType.bottomToTop;
      case NavType.rightToLeftWithFade:
        return PageTransitionType.rightToLeftWithFade;
      case NavType.leftToRightWithFade:
        return PageTransitionType.leftToRightWithFade;
      default:
        return PageTransitionType.fade;
    }
  }
}
