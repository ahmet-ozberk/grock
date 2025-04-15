import 'package:flutter/material.dart';

class GrockInfoWidget extends StatelessWidget {
  final Widget child;
  final String? message;
  final InlineSpan? richMessage;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? verticalOffset;
  final bool? preferBelow;
  final bool? excludeFromSemantics;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Duration? waitDuration;
  final Duration? showDuration;
  const GrockInfoWidget({
    Key? key,
    required this.child,
    this.message,
    this.richMessage,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: key,
      message: message ?? '',
      richMessage: richMessage,
      height: height,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.black.withValues(alpha:0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
      textStyle: textStyle,
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration ?? Duration(seconds: 4),
      triggerMode: TooltipTriggerMode.tap,
      child: child,
    );
  }
}
