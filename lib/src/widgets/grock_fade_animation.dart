import 'package:flutter/material.dart';

class GrockFadeAnimation extends StatefulWidget {
  Widget child;
  Duration duration;
  Duration opacityDuration;
  Position position;
  Curve curve;
  double value;
  GrockFadeAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.opacityDuration = const Duration(milliseconds: 400),
    this.position = Position.top,
    this.curve = Curves.easeInOut,
    this.value = 100,
  }) : super(key: key);

  @override
  State<GrockFadeAnimation> createState() => _GrockFadeAnimationState();
}

class _GrockFadeAnimationState extends State<GrockFadeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isOpacity = false;

  Tween<double> _tween(Position location) {
    if (location == Position.top || location == Position.bottom) {
      return Tween<double>(begin: widget.value, end: 0.0);
    } else if (location == Position.left ||
        location == Position.right) {
      return Tween<double>(begin: widget.value, end: 0.0);
    } else {
      return Tween<double>(begin: 0.0, end: -widget.value);
    }
  }

  Offset _offset() {
    if (widget.position == Position.top) {
      return Offset(0.0, -_animation.value);
    } else if (widget.position == Position.left) {
      return Offset(-_animation.value, 0.0);
    } else if (widget.position == Position.right) {
      return Offset(_animation.value, 0.0);
    } else if (widget.position == Position.bottom) {
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
    _animation = _tween(widget.position).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 1, curve: widget.curve)))
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
      offset: _offset(),
      child: AnimatedOpacity(
          opacity: _isOpacity ? 1 : 0,
          duration: widget.opacityDuration,
          child: widget.child),
    );
  }
}

enum Position {
  top,
  left,
  right,
  bottom,
}
