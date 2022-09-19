import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grock/src/components/lorem_ipsum.dart';

extension IntExtension on int {
  int get randomNum => Random().nextInt(this);
}

extension RandomImageExtension on int {
  String randomImage({int width = 200, int height = 200}) =>
      "https://picsum.photos/$width/$height?random=$this";
  String randomImg([int width = 320, int height = 240]) =>
      "https://loremflickr.com/$width/$height?random=$this";
  String lorem({int paragraphs = 1}) =>
      loremIpsum(paragraphs: paragraphs, words: this);
}

extension SizeBoxExtension on int {
  Widget get height => SizedBox(height: this.toDouble());
  Widget get width => SizedBox(width: this.toDouble());
  Widget get heightWidth =>
      SizedBox(height: this.toDouble(), width: this.toDouble());
}

extension WaitExtension on int {
  Future<void> wait([FutureOr<void> Function()? func]) =>
      Future.delayed(Duration(seconds: this), () => func?.call());
}

extension BorderRadiusIntExtension on int {
  BorderRadius get borderRadius => BorderRadius.circular(this.toDouble());
  BorderRadius get borderRadiusOnlyTopLeft =>
      BorderRadius.only(topLeft: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyTopRight =>
      BorderRadius.only(topRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyBottomLeft =>
      BorderRadius.only(bottomLeft: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyBottomRight =>
      BorderRadius.only(bottomRight: Radius.circular(this.toDouble()));

  BorderRadius get borderRadiusOnlyTop => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      topRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyBottom => BorderRadius.only(
      bottomLeft: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyLeft => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      bottomLeft: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyRight => BorderRadius.only(
      topRight: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));

  BorderRadius get borderRadiusOnlyTopLeftRight => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      topRight: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyTopLeftBottom => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      bottomLeft: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyTopRightBottom => BorderRadius.only(
      topRight: Radius.circular(this.toDouble()),
      bottomLeft: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
  BorderRadius get borderRadiusOnlyBottomLeftRight => BorderRadius.only(
      topLeft: Radius.circular(this.toDouble()),
      bottomLeft: Radius.circular(this.toDouble()),
      bottomRight: Radius.circular(this.toDouble()));
}

extension RandomStringExtension on int {
  static Random random = Random();
  static const charactersModel =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) =>
          charactersModel.codeUnitAt(random.nextInt(charactersModel.length))));
}
