part of grock_extension;

class GrockFullScreenDialog extends StatefulWidget {
  /// Fullscreen dialog open duration default is 600 milliseconds
  final Duration openDuration;

  /// Fullscreen dialog close duration default is 300 milliseconds
  final Duration closeDuration;

  /// Matrix rotate value default is 1000
  final int matrixRotateValue;

  /// Fullscreen dialog child
  final Widget child;

  /// If true, the dialog will be rotated when the dialog is closed.
  final bool isSlideOpacity;

  /// If you want to use your own close animation, you can use this parameter.
  final Alignment openAlignment;

  /// If you want to use your own close animation, you can use this parameter.
  final Alignment closeAlignment;

  /// If true, the dialog will be rotated when the dialog is closed.
  final bool isHorizontalSlideAnimation;

  /// If true, the dialog will be rotated when the dialog is closed.
  final bool isMatrixAnimation;

  /// If true, the scale animation will be closed when the dialog is closed.
  final bool isCloseScaleAnimation;

  /// Closure rate max is 0.5 and min is 0.1
  final double closureRate;

  /// Default close tween is [Tween<double>(begin: 0.0, end: 1.0)]
  final Tween<double>? closeTween;

  const GrockFullScreenDialog({
    required this.child,
    this.openDuration = const Duration(milliseconds: 600),
    this.closeDuration = const Duration(milliseconds: 300),
    this.closeTween,
    this.isCloseScaleAnimation = false,
    this.isMatrixAnimation = false,
    this.isHorizontalSlideAnimation = true,
    this.closureRate = 0.24,
    this.openAlignment = Alignment.bottomLeft,
    this.closeAlignment = Alignment.bottomLeft,
    this.isSlideOpacity = true,
    this.matrixRotateValue = 1000,
    super.key,
  }) : assert(closureRate <= 0.5 && closureRate >= 0.1,
            "Closure rate max is 0.5 and min is 0.1");
  static void close() => Grock.closeGrockOverlay();

  @override
  State<GrockFullScreenDialog> createState() => _GrockFullScreenDialogState();
}

class _GrockFullScreenDialogState extends State<GrockFullScreenDialog>
    with TickerProviderStateMixin {
  double dy = 0;
  double dx = 0;
  double opacity = 1;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Alignment alignment;

  @override
  void initState() {
    super.initState();
    initializeFunction();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: ScaleTransition(
        scale: _animation,
        alignment: alignment,
        child: Transform.scale(
          scale: widget.isCloseScaleAnimation
              ? 1 - (dy / context.height).abs()
              : 1,
          child: Transform.translate(
            offset: Offset(widget.isHorizontalSlideAnimation ? dx : 0, dy),
            child: Transform(
              transform: getMatrix(),
              child: Opacity(
                opacity: widget.isSlideOpacity ? opacity : 1,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initializeFunction() {
    alignment = widget.openAlignment;
    setAnimationInitialize();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(widget.openDuration, () {
        setState(() {
          alignment = widget.closeAlignment;
        });
      });
    });
  }

  void setAnimationInitialize() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.openDuration,
      reverseDuration: widget.closeDuration,
    );
    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.02)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 9,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.02, end: 1.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 3,
        ),
      ],
    ).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  void onPanUpdate(DragUpdateDetails details) {
    dy += (details.delta.dy);
    dx += (details.delta.dx);
    if (dy > context.height) dy = context.height;
    if (dy < -context.height) dy = -context.height;
    if (widget.isHorizontalSlideAnimation) {
      if (dx > context.width) dx = context.width;
      if (dx < -context.width) dx = -context.width;
    }
    opacity = 1 - (dy / context.height).abs();
    _animation = (widget.closeTween ??
            Tween<double>(
              begin: 0.0,
              end: 1.0,
            ))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    setState(() {});
  }

  void onPanEnd(DragEndDetails details) {
    if (dy < -(context.height * widget.closureRate) ||
        dy > (context.height * widget.closureRate) ||
        dx < -(context.width * widget.closureRate) ||
        dx > (context.width * widget.closureRate)) {
      closeFunction();
    } else {
      dy = 0;
      dx = 0;
      opacity = 1;
      setState(() {});
    }
  }

  Matrix4 getMatrix() {
    final matrix = Matrix4.identity();
    matrix.setEntry(3, 2, 0.001);
    if (widget.isMatrixAnimation) {
      matrix.rotateX(-dy / widget.matrixRotateValue);
      matrix.rotateY(dx / widget.matrixRotateValue);
    }
    return matrix;
  }

  void closeFunction() {
    _controller.reverse();
    Future.delayed(widget.closeDuration, () {
      _controller.dispose();
      Grock.closeGrockOverlay();
    });
  }
}
