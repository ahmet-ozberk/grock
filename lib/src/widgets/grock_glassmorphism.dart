// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';

class GrockGlassMorphism extends StatelessWidget {
  double? blur;
  double? opacity;
  Widget child;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  GrockGlassMorphism(
      {Key? key,
      required this.child,
      this.blur,
      this.opacity,
      this.color,
      this.borderRadius,
      this.border})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 10, sigmaY: blur ?? 10),
        child: Container(
          decoration: _decoration(),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: (color ?? Colors.white).withOpacity(opacity ?? 0.2),
      borderRadius: borderRadius,
      border: border ?? _border(),
    );
  }

  Border _border() {
    return Border.all(
      color: (color ?? Colors.white).withOpacity(0.1),
      width: 0.5,
    );
  }
}

class GrockBlurEffect extends StatelessWidget {
  double? blur;
  double? opacity;
  Widget child;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  GrockBlurEffect(
      {Key? key,
      required this.child,
      this.blur,
      this.opacity,
      this.color,
      this.borderRadius,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 10, sigmaY: blur ?? 10),
        child: Container(
          decoration: _decoration(),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: (color ?? Colors.white).withOpacity(opacity ?? 0.2),
      borderRadius: borderRadius,
      border: border ?? _border(),
    );
  }

  Border _border() {
    return Border.all(
      color: (color ?? Colors.white).withOpacity(0.1),
      width: 0.5,
    );
  }
}
