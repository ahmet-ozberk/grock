import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/src/enum/nav_type.dart';
import 'package:grock/src/info_grock/info_grock.dart';
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
  static Future<String>  get getVersion => InfoGrock.appVersion();
  static bool  get isDebugMode => InfoGrock.isDebugMode();
  static bool  get isReleaseMode => InfoGrock.isReleaseMode();
  static bool  get isProfileMode => InfoGrock.isProfileMode();
  


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

  static void snackBar(String message,
          {String? description,
          SnackbarPosition position = SnackbarPosition.bottom,
          SnackbarType type = SnackbarType.none,
          double padding = 12.5,
          double opacity = 1.0,
          double borderRadius = 12.5,
          double fontSize = 16,
          Color textColor = Colors.white,
          FontWeight fontWeight = FontWeight.normal,
          Duration duration = const Duration(seconds: 4),
          TextAlign textPosition = TextAlign.center,
          BoxBorder? border}) =>
      ScaffoldMessengerModel.showSnackbar(message,
          description: description,
          border: border,
          borderRadius: borderRadius,
          fontSize: fontSize,
          fontWeight: fontWeight,
          duration: duration,
          textColor: textColor,
          textPosition: textPosition,
          opacity: opacity,
          padding: padding,
          type: type);
}
