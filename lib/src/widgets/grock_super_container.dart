import 'package:flutter/material.dart';
import 'dart:math' as math;

class GrockSuperContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadiusGeometry? superBorderRadius;
  final bool isSuperBorderRadius;
  final BorderSide border;
  final Duration animationDuration;
  final Clip clipBehavior;
  final double elevation;
  final Color? shadowColor;
  final Color? tintColor;
  final TextStyle? defaultTextStyle;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final Widget? child;

  const GrockSuperContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.superBorderRadius,
    this.isSuperBorderRadius = true,
    this.border = BorderSide.none,
    this.animationDuration = const Duration(milliseconds: 200),
    this.clipBehavior = Clip.none,
    this.elevation = 0.0,
    this.shadowColor,
    this.tintColor,
    this.defaultTextStyle,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        child: Material(
          color: color,
          shape: isSuperBorderRadius
              ? GrockSuperShape(
                  borderRadius: superBorderRadius!,
                  side: border,
                )
              : null,
          animationDuration: animationDuration,
          borderRadius: isSuperBorderRadius ? null : superBorderRadius,
          clipBehavior: clipBehavior,
          elevation: elevation,
          shadowColor: shadowColor,
          key: key,
          surfaceTintColor: tintColor,
          textStyle: defaultTextStyle,
          type: MaterialType.canvas,
          child: child,
        ),
      ),
    );
  }
}




class GrockSuperShape extends ShapeBorder {
  const GrockSuperShape({
    this.side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
  });

  final BorderRadiusGeometry borderRadius;
  final BorderSide side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return GrockSuperShape(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  double _clampToShortest(RRect rrect, double value) =>
      value > rrect.shortestSide ? rrect.shortestSide : value;

  Path _getPath(RRect rrect) {
    final double left = rrect.left;
    final double right = rrect.right;
    final double top = rrect.top;
    final double bottom = rrect.bottom;

    final double tlRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusX));
    final double tlRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusY));
    final double trRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.trRadiusX));
    final double trRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.trRadiusY));
    final double blRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.blRadiusX));
    final double blRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.blRadiusY));
    final double brRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.brRadiusX));
    final double brRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.brRadiusY));

    return Path()
      ..moveTo(left, top + tlRadiusX)
      ..cubicTo(left, top, left, top, left + tlRadiusY, top)
      ..lineTo(right - trRadiusX, top)
      ..cubicTo(right, top, right, top, right, top + trRadiusY)
      ..lineTo(right, bottom - blRadiusX)
      ..cubicTo(right, bottom, right, bottom, right - blRadiusY, bottom)
      ..lineTo(left + brRadiusX, bottom)
      ..cubicTo(left, bottom, left, bottom, left, bottom - brRadiusY)
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(
        borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        Path path = getOuterPath(rect, textDirection: textDirection);
        var paint = side.toPaint();
        canvas.drawPath(path, paint);
        break;
    }
  }
}