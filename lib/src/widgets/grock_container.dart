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
  const GrockContainer({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap?.call(),
      onLongPress: () => onLongPress?.call(),
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
    );
  }
}
