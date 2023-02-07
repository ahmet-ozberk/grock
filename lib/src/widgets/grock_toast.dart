part of grock_extension;

class _GrockToastWidget extends StatefulWidget {
  final OverlayEntry overlayEntry;
  final String? text;
  final Widget? widget;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;
  final AlignmentGeometry alignment;
  final double? width;
  final Curve curve;
  final Duration? duration;
  final Duration openDuration;
  final BoxBorder? border;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  const _GrockToastWidget({
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
    required this.openDuration,
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

    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.02).chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 9,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.02, end: 1.0).chain(CurveTween(curve: Curves.linear)),
          weight: 3,
        ),
      ],
    ).animate(_controller);
    _controller.forward();
  }

  _animateClosed() {
    Future.delayed((widget.duration ?? kDuration) - widget.openDuration, () {
      _controller.reverse();
    });
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
              child: FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                  scale: _animation,
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: widget.textStyle ??
                        TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontSize: 14,
                        ),
                    textAlign: widget.textAlign,
                    overflow: widget.overflow,
                    maxLines: widget.maxLines,
                    child: GrockContainer(
                      onTap: () => widget.onTap?.call(),
                      isTapAnimation: false,
                      isKeyboardDismiss: false,
                      width: widget.width,
                      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor ?? Colors.black.withOpacity(0.8),
                        borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
                        border: widget.border,
                        boxShadow: widget.boxShadow ??
                            [
                              BoxShadow(
                                color: CupertinoColors.black.withOpacity(0.05),
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
      ),
    );
  }
}
