import 'package:flutter/material.dart';

class GrockCrossFade extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;
  final Duration duration;
  final GrockCrossFadeState? state;
  final GrockCrossFadeType type;
  final Alignment? alignment;
  const GrockCrossFade(
      {super.key,
      required this.firstChild,
      required this.secondChild,
      this.state,
      this.type = GrockCrossFadeType.fadeScale,
      this.alignment = Alignment.center,
      this.duration = const Duration(milliseconds: 300)})
      : assert(state != null);

  @override
  State<GrockCrossFade> createState() => _GrockCrossFadeState();
}

class _GrockCrossFadeState extends State<GrockCrossFade> {
  late Widget _currentChild;

  void changeState(GrockCrossFadeState state) {
    setState(() {
      _currentChild = state == GrockCrossFadeState.first
          ? widget.firstChild
          : widget.secondChild;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentChild = widget.firstChild;
  }

  @override
  void didUpdateWidget(covariant GrockCrossFade oldWidget) {
    if (oldWidget.state != widget.state) {
      changeState(widget.state!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      transitionBuilder: (child, animation) =>
          setType(widget.type, animation, child),
      child: SizedBox(
        key: ValueKey<Widget>(_currentChild),
        child: _currentChild,
      ),
    );
  }

  Widget setType(
      GrockCrossFadeType type, Animation<double> animation, Widget child) {
    switch (type) {
      case GrockCrossFadeType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case GrockCrossFadeType.scale:
        return ScaleTransition(
          scale: animation,
          alignment: widget.alignment!,
          child: child,
        );
      case GrockCrossFadeType.rotate:
        return RotationTransition(
          turns: animation,
          alignment: widget.alignment!,
          child: child,
        );
      case GrockCrossFadeType.scaleRotate:
        return ScaleTransition(
          scale: animation,
          alignment: widget.alignment!,
          child: RotationTransition(
            turns: animation,
            alignment: widget.alignment!,
            child: child,
          ),
        );
      case GrockCrossFadeType.scaleRotateFade:
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: widget.alignment!,
            child: RotationTransition(
              turns: animation,
              alignment: widget.alignment!,
              child: child,
            ),
          ),
        );
      case GrockCrossFadeType.scaleFade:
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: widget.alignment!,
            child: child,
          ),
        );
      case GrockCrossFadeType.fadeRotate:
        return FadeTransition(
          opacity: animation,
          child: RotationTransition(
            turns: animation,
            alignment: widget.alignment!,
            child: child,
          ),
        );
      case GrockCrossFadeType.fadeScale:
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: widget.alignment!,
            child: child,
          ),
        );
    }
  }
}

enum GrockCrossFadeState { first, second }

enum GrockCrossFadeType {
  fade,
  scale,
  rotate,
  scaleRotate,
  scaleRotateFade,
  scaleFade,
  fadeRotate,
  fadeScale
}
