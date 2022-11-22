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
  final bool isKeyboardDismiss;
  final bool isTapAnimation;
  final double pressedOpacity;
  GrockContainer({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GrockTapContainer(
      onTap: onTap,
      onLongPress: onLongPress,
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
  final bool isKeyboardDismiss;
  final bool isTapAnimation;
  final double pressedOpacity;
  _GrockTapContainer({
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
  });

  @override
  State<_GrockTapContainer> createState() => __GrockTapContainerState();
}

class __GrockTapContainerState extends State<_GrockTapContainer> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      color: widget.color,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: widget.decoration,
      foregroundDecoration: widget.foregroundDecoration,
      constraints: widget.constraints,
      child: GestureDetector(
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
        child: AnimatedOpacity(
          opacity: _isPressed ? widget.pressedOpacity : 1.0,
          duration: const Duration(milliseconds: 100),
          child: widget.child,
        ),
      ),
    );
  }
}
