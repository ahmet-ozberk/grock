import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'model/navigation_state.dart';
import 'model/scaffoldMessenger.dart';

extension Grock on ScaffoldMessengerModel {
  /// [Keys]

  static get snackbarMessengerKey =>
      ScaffoldMessengerModel.scaffoldMessengerKey;
  static get navigationKey => NavigationService.navigationKey;

  /// [Device Information]

  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;
  static bool get isWindows => Platform.isWindows;
  static bool get isFuchsia => Platform.isFuchsia;
  static Future<String> get getVersion => InfoGrock.appVersion();
  static bool get isDebugMode => InfoGrock.isDebugMode();
  static bool get isReleaseMode => InfoGrock.isReleaseMode();
  static bool get isProfileMode => InfoGrock.isProfileMode();

  /// [Device Screen Size]

  static double get deviceWidth => window.physicalSize.width;
  static double get deviceHeight => window.physicalSize.height;

  static double get height => ScaffoldMessengerModel.height;
  static double get width => ScaffoldMessengerModel.width;
  static Offset get topCenter => ScaffoldMessengerModel.topCenter;
  static Offset get bottomCenter => ScaffoldMessengerModel.bottomCenter;
  static Offset get center => ScaffoldMessengerModel.center;
  static Offset get topLeft => ScaffoldMessengerModel.topLeft;
  static Offset get topRight => ScaffoldMessengerModel.topRight;
  static Offset get bottomLeft => ScaffoldMessengerModel.bottomLeft;
  static Offset get bottomRight => ScaffoldMessengerModel.bottomRight;
  static Offset get centerLeft => ScaffoldMessengerModel.centerLeft;
  static Offset get centerRight => ScaffoldMessengerModel.centerRight;

  /// [Navigation]

  static Future to(Widget page, {NavType? type}) =>
      NavigationService.to(page, type: type);
  static Future toRemove(Widget page, {NavType? type}) =>
      NavigationService.toRemove(page, type: type);
  static void back({Object? result}) => NavigationService.back(result: result);

  /// [Snackbar]

  static void snackBar(
          {double? borderRadius,
          int? durationMillisecond,
          Curve? curve,
          EdgeInsets? margin,
          double? blur,
          double? opacity,
          Color? bgColor,
          double? width,
          // Color? progressColor,
          // Color? progressBgColor,
          double? padding,
          IconData? icon,
          Color? iconColor,
          double? iconSize,
          required String title,
          required String description,
          Color? titleColor,
          Color? descriptionColor,
          double? titleSize,
          double? descriptionSize,
          TextStyle? titleStyle,
          TextStyle? descriptionStyle}) =>
      GrockSnackbar.showSnackbar(
          title: title,
          description: description,
          borderRadius: borderRadius,
          curve: curve,
          durationMillisecond: durationMillisecond,
          margin: margin,
          blur: blur,
          opacity: opacity,
          bgColor: bgColor,
          width: width,
          // progressColor: progressColor,
          // progressBgColor: progressBgColor,
          padding: padding,
          icon: icon,
          iconColor: iconColor,
          iconSize: iconSize,
          titleColor: titleColor,
          descriptionColor: descriptionColor,
          titleSize: titleSize,
          descriptionSize: descriptionSize,
          titleStyle: titleStyle,
          descriptionStyle: descriptionStyle);

  static void dialog({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      GrockSnackbar.dialog(
          builder: builder,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          barrierLabel: barrierLabel,
          useSafeArea: useSafeArea,
          useRootNavigator: useRootNavigator,
          routeSettings: routeSettings);
}
