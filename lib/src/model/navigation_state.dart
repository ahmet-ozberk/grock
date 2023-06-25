import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/src/enum/nav_type.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future to(
    Widget page, {
    NavType? type,
    Widget? childCurrent,
    BuildContext? ctx,
    bool inheritTheme = false,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
    bool opaque = false,
  }) {
    return navigationKey.currentState!.push(
      type != null
          ? PageTransition(
              type: _type(type),
              child: page,
              childCurrent: childCurrent,
              ctx: ctx,
              inheritTheme: inheritTheme,
              curve: curve,
              alignment: alignment,
              duration: duration,
              reverseDuration: reverseDuration,
              fullscreenDialog: fullscreenDialog,
              opaque: opaque,
            )
          : Platform.isIOS || Platform.isMacOS
              ? CupertinoPageRoute(builder: (context) => page)
              : MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future toRemove(
    Widget page, {
    NavType? type,
    Widget? childCurrent,
    BuildContext? ctx,
    bool inheritTheme = false,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
    bool opaque = false,
  }) {
    return navigationKey.currentState!.pushAndRemoveUntil(
        type != null
            ? PageTransition(
                type: _type(type),
                child: page,
                childCurrent: childCurrent,
                ctx: ctx,
                inheritTheme: inheritTheme,
                curve: curve,
                alignment: alignment,
                duration: duration,
                reverseDuration: reverseDuration,
                fullscreenDialog: fullscreenDialog,
                opaque: opaque,
              )
            : Platform.isIOS || Platform.isMacOS
                ? CupertinoPageRoute(builder: (context) => page)
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
