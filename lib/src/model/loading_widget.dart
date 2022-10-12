import 'package:flutter/material.dart';

class GrockCustomLoadingWidget extends StatefulWidget {
  Color? backgroundColor;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  GrockCustomLoadingWidget(
      {Key? key, this.backgroundColor, this.color, this.borderRadius})
      : super(key: key);

  @override
  _GrockCustomLoadingWidgetState createState() =>
      _GrockCustomLoadingWidgetState();
}

class _GrockCustomLoadingWidgetState extends State<GrockCustomLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
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
          height: size.width * 0.25,
          width: size.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            color: widget.backgroundColor ?? Colors.black,
          ),
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 5,
            color: widget.color ?? Colors.white,
          )),
        ),
      ),
    );
  }
}
