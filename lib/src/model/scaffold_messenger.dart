import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class ScaffoldMessengerModel {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static Size size =
      View.of(Grock.context).physicalSize / View.of(Grock.context).devicePixelRatio;

  static double get height => MediaQuery.sizeOf(Grock.context).height;
  static double get width => MediaQuery.sizeOf(Grock.context).width;

}
