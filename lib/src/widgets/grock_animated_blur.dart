import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class GrockAnimatedBlur extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Color colorEffect;
  final double colorOpacity;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final void Function()? onEnd;

  const GrockAnimatedBlur({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.begin = 0.0,
    this.end = 10.0,
    this.colorEffect = Colors.black,
    this.colorOpacity = 0.2,
    this.borderRadius,
    this.border,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: begin, end: end),
        duration: duration,
        onEnd: onEnd,
        key: key,
        builder: (_, double value, __) {
          return GrockBlurEffect(
            blur: value,
            color: colorEffect,
            opacity: colorOpacity,
            borderRadius: borderRadius,
            border: border,
            child: child,
          );
        });
  }
}
