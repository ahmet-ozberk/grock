import 'package:flutter/material.dart';

/// [Grock Shimmer] is a widget that provides a shimmer effect to its child.

class GrockShimmer extends StatefulWidget {
  /// The child of the [GrockShimmer] widget.
  final Widget child;

  /// The duration of the shimmer effect.
  final Duration duration;

  /// The color of the shimmer effect.
  final Color color;

  /// The direction of the shimmer effect.
  final Axis direction;

  /// The gradient of the shimmer effect.
  final Gradient? gradient;

  /// The opacity of the shimmer effect.
  final double opacity;

  /// The curve of the shimmer effect.
  final Curve curve;

  /// The border radius of the shimmer effect.
  final BorderRadius? borderRadius;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// The border radius of the shimmer effect.
  final BorderRadiusDirectional? borderRadiusDirectional;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryDirectional;

  /// The border radius of the shimmer effect.
  final BorderRadius? borderRadiusAll;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryAll;

  /// The border radius of the shimmer effect.
  final BorderRadiusDirectional? borderRadiusDirectionalAll;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryDirectionalAll;

  /// The border radius of the shimmer effect.
  final BorderRadius? borderRadiusOnlyTopLeft;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryOnlyTopLeft;

  /// The border radius of the shimmer effect.
  final BorderRadiusDirectional? borderRadiusDirectionalOnlyTopLeft;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryDirectionalOnlyTopLeft;

  /// The border radius of the shimmer effect.
  final BorderRadius? borderRadiusOnlyTopRight;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryOnlyTopRight;

  /// The border radius of the shimmer effect.
  final BorderRadiusDirectional? borderRadiusDirectionalOnlyTopRight;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryDirectionalOnlyTopRight;

  /// The border radius of the shimmer effect.
  final BorderRadius? borderRadiusOnlyBottomLeft;

  /// The border radius of the shimmer effect.
  final BorderRadiusGeometry? borderRadiusGeometryOnlyBottomLeft;

  /// The border radius of the shimmer effect.
  final BorderRadiusDirectional? borderRadiusDirectionalOnlyBottomLeft;

  GrockShimmer({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.color = Colors.grey,
    this.direction = Axis.horizontal,
    this.gradient,
    this.opacity = 0.5,
    this.curve = Curves.linear,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.borderRadiusDirectional,
    this.borderRadiusGeometryDirectional,
    this.borderRadiusAll,
    this.borderRadiusGeometryAll,
    this.borderRadiusDirectionalAll,
    this.borderRadiusGeometryDirectionalAll,
    this.borderRadiusOnlyTopLeft,
    this.borderRadiusGeometryOnlyTopLeft,
    this.borderRadiusDirectionalOnlyTopLeft,
    this.borderRadiusGeometryDirectionalOnlyTopLeft,
    this.borderRadiusOnlyTopRight,
    this.borderRadiusGeometryOnlyTopRight,
    this.borderRadiusDirectionalOnlyTopRight,
    this.borderRadiusGeometryDirectionalOnlyTopRight,
    this.borderRadiusOnlyBottomLeft,
    this.borderRadiusGeometryOnlyBottomLeft,
    this.borderRadiusDirectionalOnlyBottomLeft,
  }) : super(key: key);

  @override
  _GrockShimmerState createState() => _GrockShimmerState();
}

class _GrockShimmerState extends State<GrockShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: widget.direction == Axis.horizontal
                  ? Alignment(_animation.value, 0.0)
                  : Alignment(0.0, _animation.value),
              end: widget.direction == Axis.horizontal
                  ? Alignment(_animation.value + 0.5, 0.0)
                  : Alignment(0.0, _animation.value + 0.5),
              colors: [
                widget.color.withOpacity(widget.opacity),
                widget.color.withOpacity(widget.opacity * 0.5),
                widget.color.withOpacity(widget.opacity),
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(rect);
          },
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: widget.borderRadius ??
            widget.borderRadiusGeometry ??
            widget.borderRadiusDirectional ??
            widget.borderRadiusGeometryDirectional ??
            widget.borderRadiusAll ??
            widget.borderRadiusGeometryAll ??
            widget.borderRadiusDirectionalAll ??
            widget.borderRadiusGeometryDirectionalAll ??
            widget.borderRadiusOnlyTopLeft ??
            widget.borderRadiusGeometryOnlyTopLeft ??
            widget.borderRadiusDirectionalOnlyTopLeft ??
            widget.borderRadiusGeometryDirectionalOnlyTopLeft ??
            widget.borderRadiusOnlyTopRight ??
            widget.borderRadiusGeometryOnlyTopRight ??
            widget.borderRadiusDirectionalOnlyTopRight ??
            widget.borderRadiusGeometryDirectionalOnlyTopRight ??
            widget.borderRadiusOnlyBottomLeft ?? widget.borderRadiusGeometryOnlyBottomLeft ?? widget.borderRadiusDirectionalOnlyBottomLeft ?? BorderRadius.zero,
        child: widget.child,
      ),
    );
  }
}
  