import 'package:flutter/material.dart';

class GrockBounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double value;
  const GrockBounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.bounceOut,
    this.value = 0.2,
  });

  @override
  State<GrockBounceAnimation> createState() => _GrockBounceAnimationState();
}

class _GrockBounceAnimationState extends State<GrockBounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curve);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: widget.key,
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
            scale: 1 + (_animation.value * 0.2), child: widget.child);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
