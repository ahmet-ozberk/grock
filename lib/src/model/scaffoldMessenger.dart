import 'dart:ui';
import 'package:flutter/material.dart';
import '../enum/snackbar_position.dart';

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
      BoxBorder? border}) {
    var topHeight =
        scaffoldMessengerKey.currentContext!.size!.topCenter(Offset.zero);
    var totalHeight = scaffoldMessengerKey.currentContext!.size!.height;
    var topPosition = totalHeight - topHeight.dx;
    Color bgColor = Colors.grey;
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
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom:
                      position == SnackbarPosition.bottom ? 0 : topPosition),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: padding / 2, horizontal: padding),
                    decoration: BoxDecoration(
                      color: bgColor.withOpacity(opacity),
                      border: border ?? Border.all(color: bgColor, width: 0.25),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: textColor,
                        fontWeight: fontWeight,
                      ),
                      textAlign: textPosition,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
