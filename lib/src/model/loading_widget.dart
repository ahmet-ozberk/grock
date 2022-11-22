import 'package:flutter/material.dart';

class GrockCustomLoadingWidget extends StatefulWidget {
  Color? backgroundColor;
  String? text;
  TextStyle? textStyle;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  bool isScale;
  Widget? child;
  double? width;
  double? height;
  GrockCustomLoadingWidget(
      {Key? key,
      this.backgroundColor,
      this.text,
      this.textStyle,
      this.color,
      this.borderRadius,
      this.isScale = true,
      this.child,
      this.height,
      this.width})
      : super(key: key);

  @override
  _GrockCustomLoadingWidgetState createState() => _GrockCustomLoadingWidgetState();
}

class _GrockCustomLoadingWidgetState extends State<GrockCustomLoadingWidget> with SingleTickerProviderStateMixin {
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
      _scaleAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(_controller);
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
      scale: _scaleAnimation,
      alignment: Alignment.center,
      child: Center(
        child: Container(
          height: widget.height ?? size.width * 0.25,
          width: widget.width ?? size.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            color: widget.backgroundColor ?? Colors.black,
          ),
          child: widget.child ??
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 5,
                        color: widget.color ?? Colors.white,
                      ),
                      if (widget.text != null) const SizedBox(height: 4),
                      if (widget.text != null)
                        Text(
                          widget.text!,
                          style: widget.textStyle ??
                              TextStyle(
                                color: widget.color ?? Colors.white,
                                fontSize: 14,
                              ),
                          textAlign: TextAlign.center,
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
