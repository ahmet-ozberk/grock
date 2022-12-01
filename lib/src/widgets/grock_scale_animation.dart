import 'package:flutter/material.dart';

class GrockScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;
  final Curve reverseCurve;
  final Offset origin;
  final double? scaleX;
  final double? scaleY;
  final AlignmentGeometry alignment;
  final Duration delay;
  final Function(AnimationController controller)? addListener;
  const GrockScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
    this.addListener,
    this.origin = Offset.zero,
    this.scaleX,
    this.scaleY,
    this.alignment = Alignment.center,
    this.delay = Duration.zero,
  });

  @override
  State<GrockScaleAnimation> createState() => _GrockScaleAnimationState();
}

class _GrockScaleAnimationState extends State<GrockScaleAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initialize();
    started();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      key: widget.key,
      scale: _animation.value,
      origin: widget.origin,
      scaleX: widget.scaleX,
      scaleY: widget.scaleY,
      alignment: widget.alignment,
      child: widget.child,
    );
  }

  void initialize() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    )..addListener(() {
        if (widget.addListener != null) {
          widget.addListener!(_controller);
        }
        setState(() {});
      });
  }

  void started() {
    Future.delayed(widget.delay, () {
      _controller.forward();
    });
  }
}
