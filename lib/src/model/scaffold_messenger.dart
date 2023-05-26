import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class ScaffoldMessengerModel {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static Size size =
      View.of(Grock.context).physicalSize / View.of(context).devicePixelRatio;
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
}
