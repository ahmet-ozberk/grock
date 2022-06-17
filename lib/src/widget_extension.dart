import 'dart:ui';

import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget visible(bool val, {double? height}) => val
      ? this
      : Visibility(
          child: this,
          visible: val,
        );

  Widget disabled([bool? disable]) =>
      IgnorePointer(ignoring: disable ?? true, child: this);

  Widget disabledOpacity([bool? disable, double? opacity]) => IgnorePointer(
      ignoring: disable ?? true,
      child: Opacity(opacity: opacity ?? 0.2, child: this));

  Widget expanded({int? flex}) => Expanded(child: this, flex: flex ?? 1);

  Widget sized({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: this,
      );

  Widget margin({double? l, double? t, double? r, double? b}) => Padding(
        padding: EdgeInsets.fromLTRB(l ?? 0, t ?? 0, r ?? 0, b ?? 0),
        child: this,
      );

  Widget get rightRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(0.5), child: this);
  Widget get upRotation => RotationTransition(
      turns: const AlwaysStoppedAnimation(0.25), child: this);
  Widget get bottomRotation => RotationTransition(
      turns: const AlwaysStoppedAnimation(0.75), child: this);
  Widget get leftRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(1), child: this);
  Widget rotate({double? value}) => RotationTransition(
      turns: AlwaysStoppedAnimation(value ?? 0), child: this);

  Widget alignment({AlignmentGeometry? align}) =>
      Align(alignment: align ?? Alignment.center, child: this);

  Widget get inChildrenHeight => IntrinsicHeight(child: this);

  Widget get inChildrenWidth => IntrinsicWidth(child: this);

  Widget tooltip(String msg,
          {Decoration? decoration,
          double? height,
          bool? preferBelow,
          EdgeInsetsGeometry? padding,
          TextStyle? textStyle,
          Duration? waitDuration,
          EdgeInsetsGeometry? margin}) =>
      Tooltip(
        message: msg,
        decoration: decoration,
        height: height,
        padding: padding,
        preferBelow: preferBelow,
        textStyle: textStyle,
        waitDuration: waitDuration,
        margin: margin,
        child: this,
      );

  Widget onTap(void Function() onTap,
          {bool isShowSplash = false, double? borderRadius}) =>
      isShowSplash
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              child: this,
            )
          : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: this,
            );
  Widget bgBlur({double blurRadius = 10, double? sigmaX, double? sigmaY}) =>
      BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: sigmaX ?? blurRadius, sigmaY: sigmaY ?? blurRadius),
        child: this,
      );

  Widget borderRadius({double? radius}) => ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: this,
      );

  Widget decoration({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    BoxShape shape = BoxShape.rectangle,
    BoxShadow? boxShadow,
    Gradient? gradient,
    DecorationImage? image,
    DecorationPosition position = DecorationPosition.background,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: border,
          shape: shape,
          boxShadow: boxShadow == null ? null : [boxShadow],
          gradient: gradient,
          image: image,
        ),
        position: position,
        child: this,
      );

  Widget colored({required Color color}) {
    return ColoredBox(color: color, child: this);
  }

  Widget get inChildrenWidthAndHeight => IntrinsicWidth(
        child: IntrinsicHeight(child: this),
      );

  Widget get inChildrenHeightAndWidth => IntrinsicHeight(
        child: IntrinsicWidth(child: this),
      );
}
