import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

extension WidgetExtension on Widget {
  Widget visible(bool val) => Visibility(
        child: this,
        visible: val,
      );

  Widget disabled([bool? disable]) =>
      IgnorePointer(ignoring: disable ?? true, child: this);

  Widget disabledOpacity([bool? disable, double? opacity]) => IgnorePointer(
      ignoring: disable ?? true,
      child: Opacity(opacity: opacity ?? 0.2, child: this));

  Widget expanded({int? flex}) => Expanded(child: this, flex: flex ?? 1);

  Widget size({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: this,
      );

  Widget margin({double? l, double? t, double? r, double? b}) => Padding(
        padding: EdgeInsets.fromLTRB(l ?? 0, t ?? 0, r ?? 0, b ?? 0),
        child: this,
      );

  Widget get rightRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(0.5), child: this);
  Widget get upRotation => RotationTransition(
      turns: const AlwaysStoppedAnimation(0.25), child: this);
  Widget get bottomRotation => RotationTransition(
      turns: const AlwaysStoppedAnimation(0.75), child: this);
  Widget get leftRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(1), child: this);
  Widget rotate({double? value}) => RotationTransition(
      turns: AlwaysStoppedAnimation(value ?? 0), child: this);

  Widget alignment({AlignmentGeometry? align}) =>
      Align(alignment: align ?? Alignment.center, child: this);

  Widget get inChildrenHeight => IntrinsicHeight(child: this);

  Widget get inChildrenWidth => IntrinsicWidth(child: this);

  Widget tooltip(String msg,
          {Decoration? decoration,
          double? height,
          bool? preferBelow,
          EdgeInsetsGeometry? padding,
          TextStyle? textStyle,
          Duration? waitDuration,
          EdgeInsetsGeometry? margin}) =>
      Tooltip(
        message: msg,
        decoration: decoration,
        height: height,
        padding: padding,
        preferBelow: preferBelow,
        textStyle: textStyle,
        waitDuration: waitDuration,
        margin: margin,
        child: this,
      );

  Widget onTap(void Function() onTap,
          {bool isShowSplash = false, double? borderRadius}) =>
      isShowSplash
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              child: this,
            )
          : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: this,
            );
  Widget bgBlur({double blurRadius = 10, double? sigmaX, double? sigmaY}) =>
      BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: sigmaX ?? blurRadius, sigmaY: sigmaY ?? blurRadius),
        child: this,
      );

  Widget borderRadius(double? radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: this,
      );

  Widget decoration({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    BoxShape shape = BoxShape.rectangle,
    BoxShadow? boxShadow,
    Gradient? gradient,
    DecorationImage? image,
    DecorationPosition position = DecorationPosition.background,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: border,
          shape: shape,
          boxShadow: boxShadow == null ? null : [boxShadow],
          gradient: gradient,
          image: image,
        ),
        position: position,
        child: this,
      );

  Widget colored({required Color color}) {
    return ColoredBox(color: color, child: this);
  }

  Widget get inChildrenWidthAndHeight => IntrinsicWidth(
        child: IntrinsicHeight(child: this),
      );

  Widget get inChildrenHeightAndWidth => IntrinsicHeight(
        child: IntrinsicWidth(child: this),
      );

  Widget red() => ColoredBox(color: Colors.red, child: this);

  Widget green() => ColoredBox(color: Colors.green, child: this);

  Widget blue() => ColoredBox(color: Colors.blue, child: this);

  Widget yellow() => ColoredBox(color: Colors.yellow, child: this);

  Widget orange() => ColoredBox(color: Colors.orange, child: this);

  Widget purple() => ColoredBox(color: Colors.purple, child: this);

  Widget shadow({Color? color, double? blurRadius, double? spreadRadius}) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color ?? Colors.black,
              blurRadius: blurRadius ?? 10,
              spreadRadius: spreadRadius ?? 0,
            ),
          ],
        ),
        child: this,
      );

  Widget blur({double? x, double? y}) => ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: x ?? 3, sigmaY: y ?? 3),
        child: this,
      );

  /// Start and End values ​​must be between 0 and 1. The Start value cannot be greater than the End value.
  Widget animatedRotation({
    double start = 0,
    double end = 1,
    Curve? curve,
    Duration? duration,
  }) =>
      GrockRotationAnimation(
        child: this,
        to: end,
        from: start,
        duration: duration,
        curve: curve,
      );
  
  void getSize(Function(Size size) callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = Grock.context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      callback(size);
    });
  }
}

extension ExpansionTileExtension on ExpansionTile {
  Widget removeDivider() => Builder(builder: (context) {
        return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: this);
      });
}

extension TextExtension on Text {
  Widget gradient(
          {required List<Color> colors,
          TileMode tileMode = TileMode.clamp,
          AlignmentGeometry begin = Alignment.centerLeft,
          AlignmentGeometry end = Alignment.centerRight}) =>
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: colors,
          tileMode: tileMode,
          begin: begin,
          end: end,
        ).createShader(bounds),
        child: this,
      );
}

// ignore: must_be_immutable
class GrockRotationAnimation extends StatefulWidget {
  final Widget child;
  Curve? curve;
  Duration? duration;
  double from;
  double to;
  GrockRotationAnimation({
    Key? key,
    required this.child,
    this.curve,
    this.duration,
    this.from = 0,
    this.to = 1,
  }) : super(key: key);

  @override
  State<GrockRotationAnimation> createState() => _GrockRotationAnimationState();
}

class _GrockRotationAnimationState extends State<GrockRotationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween(begin: widget.from, end: widget.to).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.from < 0 ? 0 : widget.from,
          widget.to,
          curve: widget.curve ?? Curves.fastOutSlowIn,
        ),
      ),
    )..addListener(() {
        setState(() {});
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
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}
