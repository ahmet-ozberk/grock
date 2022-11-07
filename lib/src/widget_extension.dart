import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

extension WidgetExtension on Widget {
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

  Widget paddingLTRB({double? left, double? right, double? top, double? bottom}) =>
      Padding(
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

  Widget shadow({Color? color, double? blurRadius, double? spreadRadius}) => Container(
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
        return Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent), child: this);
      });
}

extension TextExtension on Text {
  Text gradient(List<Color> colors) => Text(
        data ?? '',
        style: TextStyle(
          foreground: Paint()
            ..shader = LinearGradient(colors: colors).createShader(
              Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
            ),
        ),
      );

  Text get bold => Text(
        this.data ?? '',
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text get italic => Text(
        this.data ?? '',
        style: TextStyle(fontStyle: FontStyle.italic),
      );

  Text get underline => Text(
        this.data ?? '',
        style: TextStyle(decoration: TextDecoration.underline),
      );

  Text get lineThrough => Text(
        this.data ?? '',
        style: TextStyle(decoration: TextDecoration.lineThrough),
      );

  Text get overline => Text(
        this.data ?? '',
        style: TextStyle(decoration: TextDecoration.overline),
      );

  Text get uppercase => Text(
        this.data?.toUpperCase() ?? '',
      );

  Text get lowercase => Text(
        this.data?.toLowerCase() ?? '',
      );

  Text fontSize(int t) => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 20),
      );

  Text get fontSize10 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 10),
      );

  Text get fontSize12 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 12),
      );

  Text get fontSize14 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 14),
      );

  Text get fontSize16 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 16),
      );

  Text get fontSize18 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 18),
      );

  Text get fontSize20 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 20),
      );

  Text get fontSize22 => Text(
        this.data ?? '',
        style: TextStyle(fontSize: 22),
      );

  Text fontWeight(FontWeight fontWeight) => Text(
        this.data ?? '',
        style: TextStyle(fontWeight: fontWeight),
      );

  Text color(Color t) => Text(
        this.data ?? '',
        style: TextStyle(color: t),
      );

  Text get center => Text(
        this.data ?? '',
        textAlign: TextAlign.center,
      );

  Text get left => Text(
        this.data ?? '',
        textAlign: TextAlign.left,
      );

  Text get right => Text(
        this.data ?? '',
        textAlign: TextAlign.right,
      );

  Text get justify => Text(
        this.data ?? '',
        textAlign: TextAlign.justify,
      );

  Text get start => Text(
        this.data ?? '',
        textAlign: TextAlign.start,
      );

  Text get end => Text(
        this.data ?? '',
        textAlign: TextAlign.end,
      );

  Text get white => Text(
        this.data ?? '',
        style: TextStyle(color: Colors.white),
      );

  Text get black => Text(
        this.data ?? '',
        style: TextStyle(color: Colors.black),
      );
}

extension TextStyleExtension on TextStyle {
  TextStyle get bold => TextStyle(fontWeight: FontWeight.bold);

  TextStyle get italic => TextStyle(fontStyle: FontStyle.italic);

  TextStyle get underline => TextStyle(decoration: TextDecoration.underline);

  TextStyle get lineThrough => TextStyle(decoration: TextDecoration.lineThrough);

  TextStyle get overline => TextStyle(decoration: TextDecoration.overline);

  TextStyle get uppercase => TextStyle(fontWeight: FontWeight.bold);

  TextStyle get lowercase => TextStyle(fontWeight: FontWeight.bold);

  TextStyle fontSize(int t) => TextStyle(fontSize: 20);

  TextStyle get fontSize10 => TextStyle(fontSize: 10);

  TextStyle get fontSize12 => TextStyle(fontSize: 12);

  TextStyle get fontSize14 => TextStyle(fontSize: 14);

  TextStyle get fontSize16 => TextStyle(fontSize: 16);

  TextStyle get fontSize18 => TextStyle(fontSize: 18);

  TextStyle get fontSize20 => TextStyle(fontSize: 20);

  TextStyle get fontSize22 => TextStyle(fontSize: 22);

  TextStyle fontWeight(FontWeight fontWeight) => TextStyle(fontWeight: fontWeight);

  TextStyle color(Color t) => TextStyle(color: t);

  TextStyle get gradient => TextStyle(
        foreground: Paint()
          ..shader = LinearGradient(colors: [Colors.red, Colors.yellow]).createShader(
            Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
          ),
      );
}

extension StringToText on String {
  Text get text => Text(this);

  Text get bold => Text(this, style: TextStyle(fontWeight: FontWeight.bold));

  Text get italic => Text(this, style: TextStyle(fontStyle: FontStyle.italic));

  Text get underline => Text(this, style: TextStyle(decoration: TextDecoration.underline));

  Text get lineThrough => Text(this, style: TextStyle(decoration: TextDecoration.lineThrough));

  Text get overflow => Text(this, overflow: TextOverflow.ellipsis);

  Text get fontSize10 => Text(this, style: TextStyle(fontSize: 10));

  Text get fontSize12 => Text(this, style: TextStyle(fontSize: 12));

  Text get fontSize14 => Text(this, style: TextStyle(fontSize: 14));

  Text get fontSize16 => Text(this, style: TextStyle(fontSize: 16));

  Text get fontSize18 => Text(this, style: TextStyle(fontSize: 18));

  Text get fontSize20 => Text(this, style: TextStyle(fontSize: 20));

  Text fontSize(double t) => Text(this, style: TextStyle(fontSize: t));

  Text get uppercase => Text(this.toUpperCase());

  Text get lowercase => Text(this.toLowerCase());

  Text color(Color t) => Text(this, style: TextStyle(color: t));

  Text fontWeight(FontWeight fontWeight) => Text(this, style: TextStyle(fontWeight: fontWeight));

  Text get overline => Text(this, style: TextStyle(decoration: TextDecoration.overline));

  Text get center => Text(this, textAlign: TextAlign.center);

  Text gradient(List<Color> colors) => Text(
        this,
        style: TextStyle(
          foreground: Paint()
            ..shader = LinearGradient(
              colors: colors,
            ).createShader(
              Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
            ),
        ),
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

class _GrockRotationAnimationState extends State<GrockRotationAnimation> with TickerProviderStateMixin {
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
