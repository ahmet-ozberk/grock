import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grock/src/components/lorem_ipsum.dart';

extension IntExtension on int {
  int get randomNum => Random().nextInt(this);
}

Random random = Random();

extension RandomImageExtension on int {
  String randomImage({int width = 1080, int height = 720}) =>
      "https://picsum.photos/$width/$height?random=$this";
  String randomImg([int width = 1080, int height = 720]) =>
      "https://loremflickr.com/$width/$height?random=$this";
  String lorem() => loremIpsum(words: this);
}

extension SizeBoxExtension on num {
  Widget get height => SizedBox(height: this.toDouble());
  Widget get width => SizedBox(width: this.toDouble());
  Widget get heightWidth =>
      SizedBox(height: this.toDouble(), width: this.toDouble());
}

extension WaitExtension on int {
  Future<void> waitSec([FutureOr<void> Function()? func]) =>
      Future.delayed(Duration(seconds: this), () => func?.call());

  Future<void> waitMilli([FutureOr<void> Function()? func]) =>
      Future.delayed(Duration(milliseconds: this), () => func?.call());

  Future<void> waitMicro([FutureOr<void> Function()? func]) =>
      Future.delayed(Duration(microseconds: this), () => func?.call());

  Duration get days => Duration(days: this);
  Duration get hours => Duration(hours: this);
  Duration get seconds => Duration(seconds: this);
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get microseconds => Duration(microseconds: this);
}

extension BorderRadiusIntExtension on num {
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

extension PaddingIntExtension on num {
  EdgeInsetsGeometry get padding => EdgeInsets.all(this.toDouble());
  EdgeInsetsGeometry get paddingOnlyTop =>
      EdgeInsets.only(top: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyBottom =>
      EdgeInsets.only(bottom: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyLeft =>
      EdgeInsets.only(left: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyRight =>
      EdgeInsets.only(right: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyTopLeft =>
      EdgeInsets.only(top: this.toDouble(), left: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyTopRight =>
      EdgeInsets.only(top: this.toDouble(), right: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyBottomLeft =>
      EdgeInsets.only(bottom: this.toDouble(), left: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyBottomRight =>
      EdgeInsets.only(bottom: this.toDouble(), right: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyTopBottom =>
      EdgeInsets.only(top: this.toDouble(), bottom: this.toDouble());
  EdgeInsetsGeometry get paddingOnlyLeftRight =>
      EdgeInsets.only(left: this.toDouble(), right: this.toDouble());
  
  /// left and bottom and right
  EdgeInsetsGeometry get paddingOnlyLeftBottomRight =>
      EdgeInsets.only(left: this.toDouble(), bottom: this.toDouble(), right: this.toDouble());

  /// top and left and bottom
  EdgeInsetsGeometry get paddingOnlyTopLeftBottom =>
      EdgeInsets.only(top: this.toDouble(), left: this.toDouble(), bottom: this.toDouble());

  /// top and left and right
  EdgeInsetsGeometry get paddingOnlyTopLeftRight =>
      EdgeInsets.only(top: this.toDouble(), left: this.toDouble(), right: this.toDouble());
  
  /// top and right and bottom
  EdgeInsetsGeometry get paddingOnlyTopRightBottom =>
      EdgeInsets.only(top: this.toDouble(), right: this.toDouble(), bottom: this.toDouble());

  EdgeInsetsGeometry get paddingOnlyTopLeftBottomRight =>
      EdgeInsets.only(top: this.toDouble(), left: this.toDouble(), bottom: this.toDouble(), right: this.toDouble());
}

extension RandomStringExtension on int {
  static Random random = Random();
  static const charactersModel =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) =>
          charactersModel.codeUnitAt(random.nextInt(charactersModel.length))));

  /// Get random lower case string
  String get randomLowercase => getRandomString(this).toLowerCase();

  /// Get random upper case string
  String get randomUppercase => getRandomString(this).toUpperCase();

  /// get random not number string
  String get randomNotNumber =>
      getRandomString(this).replaceAll(RegExp(r'\d'), '');

  /// get random not letter string
  String get randomNotLetter =>
      getRandomString(this).replaceAll(RegExp(r'[a-zA-Z]'), '');

  /// get random not letter and number string
  String get randomNotLetterAndNumber =>
      getRandomString(this).replaceAll(RegExp(r'[a-zA-Z0-9]'), '');
}
