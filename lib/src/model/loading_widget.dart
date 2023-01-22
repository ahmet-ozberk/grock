import 'package:flutter/material.dart';

class GrockCustomLoadingWidget extends StatefulWidget {
  final Color? backgroundColor;
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double strokeWidth;
  final bool isScale;
  final Widget? child;
  final double? width;
  final double? height;
  final double startScale;
  final double endScale;
  final Gradient? gradient;
  const GrockCustomLoadingWidget(
      {Key? key,
      this.backgroundColor,
      this.text,
      this.textStyle,
      this.color,
      this.borderRadius,
      this.strokeWidth = 4,
      this.startScale = 1.0,
      this.endScale = 0.6,
      this.isScale = true,
      this.child,
      this.height,
      this.width,
      this.gradient})
      : super(key: key);

  @override
  _GrockCustomLoadingWidgetState createState() =>
      _GrockCustomLoadingWidgetState();
}

class _GrockCustomLoadingWidgetState extends State<GrockCustomLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.isScale) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 500),
        vsync: this,
      );
      _scaleAnimation =
          Tween<double>(begin: widget.startScale, end: widget.endScale)
              .animate(_controller);
      _controller.addListener(() {
        setState(() {});
      });
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScaleTransition(
      key: widget.key,
      scale: _scaleAnimation,
      alignment: Alignment.center,
      child: Center(
        child: Container(
          height: widget.height ?? size.width * 0.25,
          width: widget.width ?? size.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            color: widget.backgroundColor ?? Colors.black.withOpacity(0.8),
            gradient: widget.gradient,
          ),
          child: widget.child ??
              Padding(
                padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: widget.text == null ? 8 : 2),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: widget.strokeWidth,
                          color: widget.color ?? Colors.white,
                        ),
                      ),
                      if (widget.text != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            widget.text!,
                            style: widget.textStyle ??
                                TextStyle(
                                  color: widget.color ?? Colors.white,
                                  fontSize: 14,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
