import 'package:flutter/material.dart';

class GrockRotateAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;
  final Curve reverseCurve;
  final Offset origin;
  final AlignmentGeometry alignment;
  final Duration delay;
  final Function(AnimationController controller)? addListener;
  const GrockRotateAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
    this.addListener,
    this.origin = Offset.zero,
    this.alignment = Alignment.center,
    this.delay = Duration.zero,
  });

  @override
  State<GrockRotateAnimation> createState() => _GrockRotateAnimationState();
}

class _GrockRotateAnimationState extends State<GrockRotateAnimation>
    with TickerProviderStateMixin {
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
    return Transform.rotate(
      angle: _animation.value,
      key: widget.key,
      origin: widget.origin,
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
