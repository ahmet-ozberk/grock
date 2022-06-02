import 'dart:ui';

import 'package:flutter/material.dart';

class GrockGlassMorphism extends StatelessWidget {
  double? blur;
  double? opacity;
  Widget child;
  Color? color;
  double? borderRadius;
  BoxBorder? border;
  GrockGlassMorphism(
      {Key? key,
      required this.child,
      this.blur,
      this.opacity,
      this.color,
      this.borderRadius,this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 10, sigmaY: blur ?? 10),
        child: Container(
          decoration: BoxDecoration(
            color: (color ?? Colors.white).withOpacity(opacity ?? 0.2),
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            border: border ??
                Border.all(
                  color: (color ?? Colors.white).withOpacity(0.1),
                  width: 1.5,
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
