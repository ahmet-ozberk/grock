import 'package:flutter/material.dart';

extension BorderRadiusExtension on int {
  BorderRadiusGeometry get allBR => BorderRadius.circular(this.toDouble());
  BorderRadiusGeometry get topBR => BorderRadius.only(topLeft: Radius.circular(this.toDouble()), topRight: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get bottomBR => BorderRadius.only(bottomLeft: Radius.circular(this.toDouble()), bottomRight: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get leftBR => BorderRadius.only(topLeft: Radius.circular(this.toDouble()), bottomLeft: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get rightBR => BorderRadius.only(topRight: Radius.circular(this.toDouble()), bottomRight: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get topLeftBR => BorderRadius.only(topLeft: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get topRightBR => BorderRadius.only(topRight: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get bottomLeftBR => BorderRadius.only(bottomLeft: Radius.circular(this.toDouble()));
  BorderRadiusGeometry get bottomRightBR => BorderRadius.only(bottomRight: Radius.circular(this.toDouble()));
}