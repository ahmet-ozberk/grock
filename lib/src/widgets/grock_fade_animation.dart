import 'package:flutter/material.dart';

class GrockFadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration opacityDuration;
  final PositionF position;
  final Alignment alignment;
  final Curve curve;
  final double value;
  final bool isOpacityAnimation;
  final Function(AnimationController controller)? addListener;

  const GrockFadeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.opacityDuration = const Duration(milliseconds: 400),
    @Deprecated('Use "alignment" instead') this.position = PositionF.top,
    this.alignment = Alignment.topCenter,
    this.curve = Curves.easeInOut,
    this.value = 100,
    this.addListener,
    this.isOpacityAnimation = true,
  });

  @override
  State<GrockFadeAnimation> createState() => _GrockFadeAnimationState();
}

class _GrockFadeAnimationState extends State<GrockFadeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  bool _isOpacity = false;

  AlignmentTween _tween() {
    if (widget.alignment == Alignment.topCenter)
      return AlignmentTween(begin: Alignment.topCenter, end: Alignment.center);
    if (widget.alignment == Alignment.centerLeft)
      return AlignmentTween(begin: Alignment.centerLeft, end: Alignment.center);
    if (widget.alignment == Alignment.centerRight)
      return AlignmentTween(
          begin: Alignment.centerRight, end: Alignment.center);
    if (widget.alignment == Alignment.bottomCenter)
      return AlignmentTween(
          begin: Alignment.bottomCenter, end: Alignment.center);
    if (widget.alignment == Alignment.center)
      return AlignmentTween(begin: Alignment.center, end: Alignment.center);
    if (widget.alignment == Alignment.topLeft)
      return AlignmentTween(begin: Alignment.topLeft, end: Alignment.center);
    if (widget.alignment == Alignment.topRight)
      return AlignmentTween(begin: Alignment.topRight, end: Alignment.center);
    if (widget.alignment == Alignment.bottomLeft)
      return AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.center);
    if (widget.alignment == Alignment.bottomRight)
      return AlignmentTween(
          begin: Alignment.bottomRight, end: Alignment.center);
    return AlignmentTween(begin: Alignment.topCenter, end: Alignment.center);
  }

  Offset _offset() {
    if (widget.alignment == Alignment.topCenter)
      return Offset(0.0, _animation.value.y);
    if (widget.alignment == Alignment.centerLeft)
      return Offset(_animation.value.x, 0.0);
    if (widget.alignment == Alignment.centerRight)
      return Offset(_animation.value.x, 0.0);
    if (widget.alignment == Alignment.bottomCenter)
      return Offset(0.0, _animation.value.y);
    if (widget.alignment == Alignment.center)
      return Offset(0.0, -_animation.value.y);
    if (widget.alignment == Alignment.topLeft)
      return Offset(_animation.value.x, _animation.value.y);
    if (widget.alignment == Alignment.topRight)
      return Offset(_animation.value.x, _animation.value.y);
    if (widget.alignment == Alignment.bottomLeft)
      return Offset(_animation.value.x, _animation.value.y);
    if (widget.alignment == Alignment.bottomRight)
      return Offset(_animation.value.x, _animation.value.y);
    return Offset(0.0, _animation.value.y);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = _tween().animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 1, curve: widget.curve)))
      ..addListener(() {
        if (widget.isOpacityAnimation) {
          if (_controller.status == AnimationStatus.completed ||
              _controller.status == AnimationStatus.forward) {
            _isOpacity = true;
          } else if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _isOpacity = false;
          }
        }
        if (widget.addListener != null) {
          widget.addListener!(_controller);
        }
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
      offset: Offset(_offset().dx * widget.value, _offset().dy * widget.value),
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
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
