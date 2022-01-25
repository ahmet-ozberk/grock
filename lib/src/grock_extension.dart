import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'model/navigation_state.dart';
import 'model/scaffoldMessenger.dart';

import 'enum/snackbar_position.dart';

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

  /// [Device Screen Size]

  static double get deviceWidth => window.physicalSize.width;
  static double get deviceHeight => window.physicalSize.height;

  // static double get height => ScaffoldMessengerModel.height;
  // static double get width => ScaffoldMessengerModel.width;
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

  static Future to(Widget page) => NavigationService.to(page);
  static Future toRemove(Widget page) => NavigationService.toRemove(page);
  static void back() => NavigationService.back();

  /// [Snackbar]

  static void snackBar(String message,
          {SnackbarPosition position = SnackbarPosition.bottom,
          SnackbarType type = SnackbarType.none,
          double padding = 16,
          double opacity = 0.6,
          double borderRadius = 10,
          double fontSize = 14,
          Color textColor = Colors.white,
          FontWeight fontWeight = FontWeight.normal,
          Duration duration = const Duration(seconds: 3),
          TextAlign textPosition = TextAlign.center,
          BoxBorder? border}) =>
      ScaffoldMessengerModel.showSnackbar(message,
          border: border,
          borderRadius: borderRadius,
          fontSize: fontSize,
          fontWeight: fontWeight,
          duration: duration,
          textColor: textColor,
          textPosition: textPosition,
          opacity: opacity,
          padding: padding,
          position: position,
          type: type);
}
