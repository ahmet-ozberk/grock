import 'package:flutter/material.dart';

class GrockGradientText extends StatelessWidget {
  final Text textWidget;
  final Gradient gradient;

  const GrockGradientText({
    required this.textWidget,
    required this.gradient,
  });

  GrockGradientText.colors({
    required this.textWidget,
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) : gradient = LinearGradient(colors: colors, begin: begin, end: end);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      child: textWidget,
    );
  }
}