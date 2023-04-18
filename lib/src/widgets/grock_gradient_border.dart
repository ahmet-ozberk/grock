import 'package:flutter/material.dart';

/// A widget that draws a gradient border around its child.
class GrockGradientBorder extends StatelessWidget {
  final Gradient gradient;
  final Widget child;
  final double strokeWidth;
  final double borderRadius;
  const GrockGradientBorder(
      {super.key,

      /// The gradient to use when drawing the border.
      required this.gradient,

      /// The child to draw the border around.
      required this.child,

      /// The width of the border.
      this.strokeWidth = 1,

      /// The border radius.
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return GradientBorderContainer(
      strokeWidth: strokeWidth,
      gradient: gradient,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final double borderRadius;

  _GradientBorderPainter({
    this.strokeWidth = 1,
    required this.gradient,
    this.borderRadius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(borderPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Gradient gradient;
  final double borderRadius;

  GradientBorderContainer({
    Key? key,

    /// The child to draw the border around.
    required this.child,

    /// The width of the border.
    this.strokeWidth = 1,

    /// The gradient to use when drawing the border.
    required this.gradient,

    /// The border radius.
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientBorderPainter(
        strokeWidth: strokeWidth,
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: Container(
        child: child,
      ),
    );
  }
}
