import 'dart:ui';

import 'package:flutter/material.dart';

class GrockGlassMorphism extends StatelessWidget {
  double blur;
  double opacity;
  Widget child;
  Color color;
  double? borderRadius;
  GrockGlassMorphism(
      {Key? key,
      required this.blur,
      required this.opacity,
      required this.child,
      required this.color,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            border: Border.all(
              color: color.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}