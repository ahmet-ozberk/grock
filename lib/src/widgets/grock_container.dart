import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrockContainer extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;

  /// Whether to dismiss the keyboard when the button is pressed. Defaults to true.
  final bool isKeyboardDismiss;

  /// Whether to show the tap animation. Defaults to true.
  final bool isTapAnimation;

  /// The opacity of the button when the button is pressed. Defaults to 0.4.
  final double pressedOpacity;

  /// The duration of the opacity animation when the button is pressed. Defaults to 10ms.
  final int pressedOpacityDuration;

  /// The duration of the animation when the Container Animated. Defaults to 200ms.
  final Duration animatedDuration;

  /// The animated container transform alignment.
  final AlignmentGeometry animatedAlignment;
  const GrockContainer({
    Key? key,
    this.onTap,
    this.onLongPress,
    this.child,
    this.color,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.isTapAnimation = true,
    this.pressedOpacity = 0.4,
    this.isKeyboardDismiss = true,
    this.animatedDuration = const Duration(milliseconds: 200),
    this.pressedOpacityDuration = 10,
    this.animatedAlignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GrockTapContainer(
      onTap: onTap,
      onLongPress: onLongPress,
      animatedDuration: animatedDuration,
      pressedOpacityDuration: pressedOpacityDuration,
      child: child,
      color: color,
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      pressedOpacity: isTapAnimation ? pressedOpacity : 1,
      isKeyboardDismiss: isKeyboardDismiss,
      isTapAnimation: isTapAnimation,
      animatedAlignment: animatedAlignment,
      key: key,
    );
  }
}

class _GrockTapContainer extends StatefulWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;

  /// Whether to dismiss the keyboard when the button is pressed. Defaults to true.
  final bool isKeyboardDismiss;

  /// Whether to show the tap animation. Defaults to true.
  final bool isTapAnimation;

  /// The opacity of the button when the button is pressed. Defaults to 0.4.
  final double pressedOpacity;

  /// The duration of the opacity animation when the button is pressed. Defaults to 10ms.
  final int pressedOpacityDuration;

  /// The duration of the animation when the Container Animated. Defaults to 200ms.
  final Duration animatedDuration;

  final AlignmentGeometry animatedAlignment;

  const _GrockTapContainer({
    super.key,
    this.onTap,
    this.onLongPress,
    this.child,
    this.color,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.isTapAnimation = true,
    this.pressedOpacity = 0.4,
    this.isKeyboardDismiss = true,
    required this.pressedOpacityDuration,
    required this.animatedDuration,
    required this.animatedAlignment,
  });

  @override
  State<_GrockTapContainer> createState() => __GrockTapContainerState();
}

class __GrockTapContainerState extends State<_GrockTapContainer> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap?.call();
        if (widget.isKeyboardDismiss) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      onLongPress: widget.onLongPress,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        key: widget.key,
        duration: widget.animatedDuration,
        color: widget.color,
        width: widget.width,
        transformAlignment: widget.animatedAlignment,
        height: widget.height,
        alignment: widget.alignment,
        padding: widget.padding,
        margin: widget.margin,
        decoration: widget.decoration,
        foregroundDecoration: widget.foregroundDecoration,
        constraints: widget.constraints,
        child: AnimatedOpacity(
          opacity: _isPressed ? widget.pressedOpacity : 1.0,
          duration: Duration(milliseconds: widget.pressedOpacityDuration),
          child: widget.child,
        ),
      ),
    );
  }
}
