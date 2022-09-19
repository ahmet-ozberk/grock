import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/toast_enum.dart';

class GrockToastWidget extends StatefulWidget {
  OverlayEntry overlayEntry;
  String? text;
  Widget? child;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  ToastTheme? theme;
  Color? backgroundColor;
  Color? textColor;
  List<BoxShadow>? boxShadow;
  TextStyle? textStyle;
  AlignmentGeometry alignment;
  double? width;
  Curve curve = Curves.fastLinearToSlowEaseIn;
  Duration? duration;
  BoxBorder? border;
  TextAlign textAlign;
  TextOverflow overflow;
  int? maxLines;
  GrockToastWidget({
    Key? key,
    required this.overlayEntry,
    this.text,
    this.child,
    this.curve = Curves.bounceOut,
    this.duration,
    this.theme,
    this.backgroundColor,
    this.borderRadius,
    this.alignment = Alignment.bottomCenter,
    this.padding,
    this.margin,
    this.textColor,
    this.boxShadow,
    this.border,
    this.textStyle,
    this.width,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  }) : super(key: key);

  @override
  State<GrockToastWidget> createState() => _GrockToastWidgetState();
}

class _GrockToastWidgetState extends State<GrockToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final kDuration = const Duration(seconds: 2);
  final kAnimateDuration = const Duration(milliseconds: 200);

  _animateStart() {
    _controller = AnimationController(
      vsync: this,
      duration: kAnimateDuration,
      reverseDuration: kAnimateDuration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.curve,
    );
    _controller.forward();
  }

  _animateClosed() {
    Future.delayed((widget.duration ?? kDuration) - kAnimateDuration, () {
      _controller.reverse();
    });
  }

  _setTheme() {
    widget.theme ??=
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ToastTheme.dark
            : ToastTheme.light;
  }

  _closeToast() {
    Future.delayed(widget.duration ?? kDuration, () {
      widget.overlayEntry.remove();
    });
  }

  @override
  void initState() {
    _animateStart();
    _animateClosed();
    _closeToast();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //_setTheme();
    super.didChangeDependencies();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: widget.alignment,
        child: Padding(
          padding: widget.margin ??
              EdgeInsets.symmetric(
                  vertical: size.height * 0.1, horizontal: size.width * 0.1),
          child: ScaleTransition(
            scale: _animation,
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: widget.textStyle ??
                  TextStyle(
                    color: widget.textColor ??
                        widget.theme?.textColor ??
                        Colors.white,
                    fontSize: 14,
                  ),
              textAlign: widget.textAlign,
              overflow: widget.overflow,
              maxLines: widget.maxLines,
              child: Container(
                width: widget.width,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ??
                      widget.theme?.backgroundColor ??
                      Colors.black.withOpacity(0.6),
                  borderRadius: widget.borderRadius ??
                      const BorderRadius.all(Radius.circular(12)),
                  border: widget.border,
                  boxShadow: widget.boxShadow ??
                      [
                        BoxShadow(
                          color: widget.theme?.textColor.withOpacity(0.05) ??
                              CupertinoColors.black.withOpacity(0.05),
                          blurRadius: 15,
                        ),
                      ],
                ),
                child: widget.child ??
                    Text(
                      widget.text ?? "",
                      textAlign: widget.textAlign,
                      overflow: widget.overflow,
                      maxLines: widget.maxLines,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
