import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

extension WidgetExtension on Widget {
  Material material() => Material(type: MaterialType.transparency, child: this);

  Widget visible(bool val) => Visibility(
        child: this,
        visible: val,
      );

  Widget disabled([bool? disable]) => IgnorePointer(ignoring: disable ?? true, child: this);

  Widget disabledOpacity([bool? disable, double? opacity]) =>
      IgnorePointer(ignoring: disable ?? true, child: Opacity(opacity: opacity ?? 0.2, child: this));

  Widget expanded({int? flex}) => Expanded(child: this, flex: flex ?? 1);

  Widget size({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: this,
      );

  Widget padding(
          {double? all,
          double? horizontal,
          double? vertical,
          double? left,
          double? right,
          double? top,
          double? bottom}) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left ?? horizontal ?? all ?? 0, top ?? vertical ?? all ?? 0,
            right ?? horizontal ?? all ?? 0, bottom ?? vertical ?? all ?? 0),
        child: this,
      );

  Widget paddingLTRB({double? left, double? right, double? top, double? bottom}) => Padding(
        padding: EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0),
        child: this,
      );

  Widget paddingAll(double val) => Padding(padding: EdgeInsets.all(val), child: this);

  Widget paddingOnly(
          {double? left, double? right, double? top, double? bottom, double? horizontal, double? vertical}) =>
      Padding(
        padding: EdgeInsets.only(
            left: left ?? horizontal ?? 0,
            right: right ?? horizontal ?? 0,
            top: top ?? vertical ?? 0,
            bottom: bottom ?? vertical ?? 0),
        child: this,
      );

  Widget paddingOnlyLeft(double val) => Padding(padding: EdgeInsets.only(left: val), child: this);

  Widget paddingOnlyRight(double val) => Padding(padding: EdgeInsets.only(right: val), child: this);

  Widget paddingOnlyTop(double val) => Padding(padding: EdgeInsets.only(top: val), child: this);

  Widget paddingOnlyBottom(double val) => Padding(padding: EdgeInsets.only(bottom: val), child: this);

  Widget paddingHorizontal(double val) => Padding(padding: EdgeInsets.symmetric(horizontal: val), child: this);

  Widget paddingVertical(double val) => Padding(padding: EdgeInsets.symmetric(vertical: val), child: this);

  Widget paddingTopLeft(double top, double left) => Padding(
        padding: EdgeInsets.only(top: top, left: left),
        child: this,
      );

  Widget paddingTopRight(double top, double right) => Padding(
        padding: EdgeInsets.only(top: top, right: right),
        child: this,
      );

  Widget paddingBottomLeft(double bottom, double left) => Padding(
        padding: EdgeInsets.only(bottom: bottom, left: left),
        child: this,
      );

  Widget paddingBottomRight(double bottom, double right) => Padding(
        padding: EdgeInsets.only(bottom: bottom, right: right),
        child: this,
      );

  Widget margin({double? l, double? t, double? r, double? b}) => Padding(
        padding: EdgeInsets.fromLTRB(l ?? 0, t ?? 0, r ?? 0, b ?? 0),
        child: this,
      );

  Widget marginAll(double val) => Padding(
        padding: EdgeInsets.all(val),
        child: this,
      );

  Widget get rotationRight => RotationTransition(turns: const AlwaysStoppedAnimation(0.5), child: this);
  Widget get rotationUp => RotationTransition(turns: const AlwaysStoppedAnimation(0.25), child: this);
  Widget get rotationBottom => RotationTransition(turns: const AlwaysStoppedAnimation(0.75), child: this);
  Widget get rotationLeft => RotationTransition(turns: const AlwaysStoppedAnimation(1), child: this);
  Widget rotate({double? value}) => RotationTransition(turns: AlwaysStoppedAnimation(value ?? 0), child: this);
  Widget rotateBox({int? value}) => RotatedBox(quarterTurns: value ?? 0, child: this);

  Widget alignment({AlignmentGeometry? align}) => Align(alignment: align ?? Alignment.center, child: this);
  Widget align({AlignmentGeometry? align}) => Align(alignment: align ?? Alignment.center, child: this);

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

  Widget onTap(void Function() onTap, {bool isShowSplash = false, double? borderRadius}) => isShowSplash
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
  Widget bgBlur({double blurRadius = 10, double? sigmaX, double? sigmaY}) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX ?? blurRadius, sigmaY: sigmaY ?? blurRadius),
        child: this,
      );

  Widget borderRadius(double? radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: this,
      );

  Widget get center => Center(child: this);

  Widget get scrollable => SingleChildScrollView(child: this);

  Widget get scrollableVertical => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: this,
      );

  Widget get scrollableHorizontal => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: this,
      );

  Widget get scrollableVerticalAlways => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: this,
      );

  Widget get scrollableHorizontalAlways => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        child: this,
      );

  Widget get scrollableVerticalNever => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        child: this,
      );

  Widget get scrollableHorizontalNever => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: this,
      );

  Widget get forgroundGradient => ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: <Color>[Colors.black, Colors.transparent, Colors.black],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: this,
      );

  Widget get oval => ClipOval(child: this);

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

  Widget shadow({
    Color? color,
    double? blurRadius,
    double? spreadRadius,
    Offset? offset,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color ?? Colors.black,
              blurRadius: blurRadius ?? 10,
              spreadRadius: spreadRadius ?? 0,
              offset: offset ?? Offset(0, 0),
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
      _GrockRotationAnimation(
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
        return Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent), child: this);
      });
}

// ignore: must_be_immutable
class _GrockRotationAnimation extends StatefulWidget {
  final Widget child;
  Curve? curve;
  Duration? duration;
  double from;
  double to;
  _GrockRotationAnimation({
    Key? key,
    required this.child,
    this.curve,
    this.duration,
    this.from = 0,
    this.to = 1,
  }) : super(key: key);

  @override
  State<_GrockRotationAnimation> createState() => __GrockRotationAnimationState();
}

class __GrockRotationAnimationState extends State<_GrockRotationAnimation> with TickerProviderStateMixin {
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
