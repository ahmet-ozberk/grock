import 'package:flutter/material.dart';

extension BorderRadiusExtension on int {
  BorderRadius get allBR => BorderRadius.circular(this.toDouble());
  BorderRadius get topBR => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      topRight: Radius.circular(this.toDouble()));
  BorderRadius get bottomBR => BorderRadius.only(
      bottomLeft: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get leftBR => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      bottomLeft: Radius.circular(this.toDouble()));
  BorderRadius get rightBR => BorderRadius.only(
      topRight: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get topLeftBR =>
      BorderRadius.only(topLeft: Radius.circular(this.toDouble()));
  BorderRadius get topRightBR =>
      BorderRadius.only(topRight: Radius.circular(this.toDouble()));
  BorderRadius get bottomLeftBR =>
      BorderRadius.only(bottomLeft: Radius.circular(this.toDouble()));
  BorderRadius get bottomRightBR =>
      BorderRadius.only(bottomRight: Radius.circular(this.toDouble()));
}
