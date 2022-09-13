import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrockContainer extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  bool isTapAnimation = true;
  double pressedOpacity = 0.4;
  GrockContainer({
    Key? key,
    this.onTap,
    this.onLongPress,
    this.child,
    this.color,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.isTapAnimation = true,
    this.pressedOpacity = 0.4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTapAnimation) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primaryContrastingColor: Colors.black,
          textTheme: CupertinoTextThemeData(),
        ),
        child: CupertinoButton(
          key: key,
          padding: EdgeInsets.zero,
          onPressed: () => onTap?.call(),
          color: color,
          pressedOpacity: pressedOpacity,
          child: Container(
            key: key,
            color: color,
            width: width,
            height: height,
            alignment: alignment,
            padding: padding,
            margin: margin,
            decoration: decoration,
            foregroundDecoration: foregroundDecoration,
            constraints: constraints,
            child: child,
          ),
        ),
      );
    }
    return GestureDetector(
      key: key,
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap?.call(),
      onLongPress: () => onLongPress?.call(),
      child: Container(
        color: color,
        width: width,
        height: height,
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: constraints,
        child: child,
      ),
    );
  }
}
