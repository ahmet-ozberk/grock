import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grock/src/components/lorem_ipsum.dart';

extension IntExtension on int {
  int get randomNum => Random().nextInt(this);
}

Random random = Random();

extension RandomImageExtension<T> on int {
  String randomImage({int width = 1080, int height = 720}) =>
      "https://picsum.photos/$width/$height?random=$this";

  String randomImg([int width = 1080, int height = 720]) =>
      "https://loremflickr.com/$width/$height?random=$this";

  String get lorem => loremIpsum(words: this);

  List<T> repeat(T Function(int count) func) {
    return [for (var i = 1; i <= abs(); i++) func(i)];
  }

  List<int> rangeTo([int? to]) {
    if (to == null) {
      return [for (var i = 1; i <= abs(); i++) i];
    } else {
      return [for (var i = this; i <= to; i++) i];
    }
  }

  List<int> rangeDownTo([int? to]) {
    if (to == null) {
      return [for (var i = 1; i >= abs(); i--) i];
    } else {
      return [for (var i = this; i >= to; i--) i];
    }
  }
}

extension SizeBoxExtension on num {
  Widget get height => SizedBox(height: this.toDouble());
  Widget get width => SizedBox(width: this.toDouble());
  Widget get heightWidth =>
      SizedBox(height: this.toDouble(), width: this.toDouble());
  Widget get box => SizedBox(
        height: this.toDouble(),
        width: this.toDouble(),
      );
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
  EdgeInsetsGeometry get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: this.toDouble());
  EdgeInsetsGeometry get paddingVertical =>
      EdgeInsets.symmetric(vertical: this.toDouble());
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
  EdgeInsetsGeometry get paddingOnlyLeftBottomRight => EdgeInsets.only(
      left: this.toDouble(), bottom: this.toDouble(), right: this.toDouble());

  /// top and left and bottom
  EdgeInsetsGeometry get paddingOnlyTopLeftBottom => EdgeInsets.only(
      top: this.toDouble(), left: this.toDouble(), bottom: this.toDouble());

  /// top and left and right
  EdgeInsetsGeometry get paddingOnlyTopLeftRight => EdgeInsets.only(
      top: this.toDouble(), left: this.toDouble(), right: this.toDouble());

  /// top and right and bottom
  EdgeInsetsGeometry get paddingOnlyTopRightBottom => EdgeInsets.only(
      top: this.toDouble(), right: this.toDouble(), bottom: this.toDouble());

  EdgeInsetsGeometry get paddingOnlyTopLeftBottomRight => EdgeInsets.only(
      top: this.toDouble(),
      left: this.toDouble(),
      bottom: this.toDouble(),
      right: this.toDouble());

  /// If 'this' is less than the given value, the value 'this' is returned, but if not, the value 'value' is returned. 
  double maxEqual(double value) {
    if (this <= value) {
      return toDouble();
    } else {
      return value;
    }
  }

  /// If 'this' is greater than the given value, the value 'this' is returned, but if not, the value 'value' is returned.
  double minEqual(double value) {
    if (this >= value) {
      return toDouble();
    } else {
      return value;
    }
  }
}

extension RandomStringExtension on int {
  static Random random = Random();
  static const charactersModel =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String get getRandomString => String.fromCharCodes(Iterable.generate(
      this,
      (_) =>
          charactersModel.codeUnitAt(random.nextInt(charactersModel.length))));

  /// Get random lower case string
  String get randomLowercase => getRandomString.toLowerCase();

  /// Get random upper case string
  String get randomUppercase => getRandomString.toUpperCase();

  /// get random not number string
  String get randomNotNumber => getRandomString.replaceAll(RegExp(r'\d'), '');

  /// get random not letter string
  String get randomNotLetter =>
      getRandomString.replaceAll(RegExp(r'[a-zA-Z]'), '');

  /// get random not letter and number string
  String get randomNotLetterAndNumber =>
      getRandomString.replaceAll(RegExp(r'[a-zA-Z0-9]'), '');

  /// Digits
  String get twoDigits => this.toString().padLeft(2, '0');
  String get threeDigits => this.toString().padLeft(3, '0');
  String get fourDigits => this.toString().padLeft(4, '0');
  String get fiveDigits => this.toString().padLeft(5, '0');
  String get sixDigits => this.toString().padLeft(6, '0');
  String get sevenDigits => this.toString().padLeft(7, '0');
  String get eightDigits => this.toString().padLeft(8, '0');
  String get nineDigits => this.toString().padLeft(9, '0');
}
