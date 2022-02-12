import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:grock/grock.dart';

class ScaffoldMessengerModel {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static Size size = WidgetsBinding.instance!.window.physicalSize /
      WidgetsBinding.instance!.window.devicePixelRatio;
  static double get height => size.height;
  static double get width => size.width;
  static Offset get topCenter =>
      scaffoldMessengerKey.currentContext!.size!.topCenter(Offset.zero);
  static Offset get bottomCenter =>
      scaffoldMessengerKey.currentContext!.size!.bottomCenter(Offset.zero);
  static Offset get center =>
      scaffoldMessengerKey.currentContext!.size!.center(Offset.zero);
  static Offset get topLeft =>
      scaffoldMessengerKey.currentContext!.size!.topLeft(Offset.zero);
  static Offset get topRight =>
      scaffoldMessengerKey.currentContext!.size!.topRight(Offset.zero);
  static Offset get bottomLeft =>
      scaffoldMessengerKey.currentContext!.size!.bottomLeft(Offset.zero);
  static Offset get bottomRight =>
      scaffoldMessengerKey.currentContext!.size!.bottomRight(Offset.zero);
  static Offset get centerLeft =>
      scaffoldMessengerKey.currentContext!.size!.centerLeft(Offset.zero);
  static Offset get centerRight =>
      scaffoldMessengerKey.currentContext!.size!.centerRight(Offset.zero);

  static void showSnackbar(String message,
      {String? description,
      double? width,
      SnackbarType type = SnackbarType.none,
      Color? backgroundColor,
      double padding = 12.5,
      double opacity = 1.0,
      double borderRadius = 12.5,
      double fontSize = 16,
      Color textColor = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      Duration duration = const Duration(seconds: 4),
      TextAlign textPosition = TextAlign.center,
      BoxBorder? border}) {
    var topHeight =
        scaffoldMessengerKey.currentContext!.size!.topCenter(Offset.zero);
    var totalHeight = scaffoldMessengerKey.currentContext!.size!.height;
    var topPosition = totalHeight -
        (scaffoldMessengerKey.currentContext!.mediaQuery.padding.top * 3);
    var topWidth = scaffoldMessengerKey.currentContext!.size!.width;
    Color bgColor = Colors.grey;

    if (backgroundColor != null) {
      bgColor = backgroundColor;
    } else {
      if (type == SnackbarType.none) {
        bgColor = Colors.grey;
      } else if (type == SnackbarType.success) {
        bgColor = Colors.green;
      } else if (type == SnackbarType.error) {
        bgColor = Colors.red;
      } else if (type == SnackbarType.warning) {
        bgColor = Colors.orange;
      } else if (type == SnackbarType.info) {
        bgColor = Colors.blue;
      }
    }

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: width,
            transformAlignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(
              vertical: padding,
              horizontal: padding,
            ),
            decoration: BoxDecoration(
              color: bgColor.withOpacity(opacity),
              border: border ?? Border.all(color: bgColor, width: 0.25),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: description == null
                ? Text(
                    message,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight,
                    ),
                    textAlign: textPosition,
                  )
                : Column(
                    crossAxisAlignment: textPosition == TextAlign.center
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: textPosition,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: fontWeight,
                        ),
                        textAlign: textPosition,
                      )
                    ],
                  ),
          ),
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
