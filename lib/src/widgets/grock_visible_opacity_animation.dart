import 'package:flutter/material.dart';

class GrockVisibleOpacityAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  /// Use:
  /// ```dart
  /// ValueNotifier<bool> onVisible = ValueNotifier(false);
  ///
  /// Future.delayed(Duration(seconds: 2), () {
  ///  // Change value
  ///  onVisible.value = true;
  /// });
  ///
  /// GrockVisibleOpacityAnimation(
  ///   onVisible: ValueNotifier(true),
  ///   child: child..
  /// ),
  /// ```
  final ValueNotifier<bool>? onVisible;
  const GrockVisibleOpacityAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.onVisible,
  });

  @override
  State<GrockVisibleOpacityAnimation> createState() =>
      _GrockVisibleOpacityAnimationState();
}

class _GrockVisibleOpacityAnimationState
    extends State<GrockVisibleOpacityAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool isVisible = false;

  void init() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    widget.onVisible?.addListener(() {
      if (widget.onVisible?.value ?? false) {
        _animation.addListener(() {
          setState(() {});
        });
        _controller.forward();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration,
      child: SizedBox(
        height: isVisible ? 0 : null,
        width: isVisible ? 0 : null,
        child: AnimatedOpacity(
          opacity: _animation.value,
          duration: widget.duration,
          onEnd: () => setState(() => isVisible = true),
          child: widget.child,
        ),
      ),
    );
  }
}
