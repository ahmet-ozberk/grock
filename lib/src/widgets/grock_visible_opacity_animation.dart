import 'package:flutter/material.dart';

class GrockVisibleOpacityAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final bool visible;
  const GrockVisibleOpacityAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.begin = 0.0,
    this.end = 1.0,
    this.visible = true,
  });

  @override
  State<GrockVisibleOpacityAnimation> createState() => _GrockVisibleOpacityAnimationState();
}

class _GrockVisibleOpacityAnimationState extends State<GrockVisibleOpacityAnimation> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedOpacity(
        opacity: widget.visible ? widget.end : widget.begin,
        duration: widget.duration,
        child: widget.child,
        onEnd: () {
          if (widget.visible == false) {
            setState(() {
              isVisible = false;
            });
          }
        },
      ),
    );
  }
}
