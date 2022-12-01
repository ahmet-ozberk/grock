import 'package:flutter/material.dart';

class GrockFadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration opacityDuration;
  final PositionF position;
  final Curve curve;
  final double value;
  const GrockFadeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.opacityDuration = const Duration(milliseconds: 400),
    this.position = PositionF.top,
    this.curve = Curves.easeInOut,
    this.value = 100,
  });

  @override
  State<GrockFadeAnimation> createState() => _GrockFadeAnimationState();
}

class _GrockFadeAnimationState extends State<GrockFadeAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isOpacity = false;

  Tween<double> _tween(PositionF location) {
    if (location == PositionF.top || location == PositionF.bottom) {
      return Tween<double>(begin: widget.value, end: 0.0);
    } else if (location == PositionF.left || location == PositionF.right) {
      return Tween<double>(begin: widget.value, end: 0.0);
    } else {
      return Tween<double>(begin: 0.0, end: -widget.value);
    }
  }

  Offset _offset() {
    if (widget.position == PositionF.top) {
      return Offset(0.0, -_animation.value);
    } else if (widget.position == PositionF.left) {
      return Offset(-_animation.value, 0.0);
    } else if (widget.position == PositionF.right) {
      return Offset(_animation.value, 0.0);
    } else if (widget.position == PositionF.bottom) {
      return Offset(0.0, _animation.value);
    } else {
      return Offset(0.0, -_animation.value);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = _tween(widget.position)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 1, curve: widget.curve)))
      ..addListener(() {
        _isOpacity = true;
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      key: widget.key,
      offset: _offset(),
      child: AnimatedOpacity(
        opacity: _isOpacity ? 1 : 0,
        duration: widget.opacityDuration,
        child: widget.child,
      ),
    );
  }
}

enum PositionF {
  top,
  left,
  right,
  bottom,
}
