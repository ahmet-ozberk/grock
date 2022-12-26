// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../enum/toast_enum.dart';

part of '../grock_extension.dart';

class _GrockToastWidget extends StatefulWidget {
  final OverlayEntry overlayEntry;
  final String? text;
  final Widget? widget;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  ToastTheme? theme;
  final Function? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;
  final AlignmentGeometry alignment;
  final double? width;
  Curve curve;
  Duration? duration;
  Duration openDuration;
  BoxBorder? border;
  TextAlign textAlign;
  TextOverflow overflow;
  int? maxLines;
  _GrockToastWidget({
    Key? key,
    required this.overlayEntry,
    this.onTap,
    this.text,
    this.widget,
    this.child,
    this.curve = Curves.bounceOut,
    /// [4 seconds]
    this.duration,
    /// [600 milliseconds]
    this.openDuration = const Duration(milliseconds: 600),
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
  State<_GrockToastWidget> createState() => _GrockToastWidgetState();
}

class _GrockToastWidgetState extends State<_GrockToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final kDuration = const Duration(seconds: 4);

  _animateStart() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.openDuration,
      reverseDuration: Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: Curves.easeOut,
      ),
    );
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: widget.curve,
    //   reverseCurve: widget.curve,
    // );
    _controller.forward();
  }

  _animateClosed() {
    Future.delayed((widget.duration ?? kDuration) - widget.openDuration, () {
      _controller.reverse();
    });
  }

  _setTheme() {
    widget.theme ??= MediaQuery.of(context).platformBrightness == Brightness.dark ? ToastTheme.dark : ToastTheme.light;
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
        child: widget.widget ??
            Padding(
              padding: widget.margin ?? EdgeInsets.symmetric(vertical: size.height * 0.1, horizontal: size.width * 0.1),
              child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: widget.textStyle ??
                      TextStyle(
                        color: widget.textColor ?? widget.theme?.textColor ?? Colors.white,
                        fontSize: 14,
                      ),
                  textAlign: widget.textAlign,
                  overflow: widget.overflow,
                  maxLines: widget.maxLines,
                  child: GrockContainer(
                    onTap: () => widget.onTap?.call(),
                    width: widget.width,
                    padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? widget.theme?.backgroundColor ?? Colors.black.withOpacity(0.8),
                      borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
                      border: widget.border,
                      boxShadow: widget.boxShadow ??
                          [
                            BoxShadow(
                              color:
                                  widget.theme?.textColor.withOpacity(0.05) ?? CupertinoColors.black.withOpacity(0.05),
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
