library grock_x_menu_overlay;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

part 'grock_x_menu_controller.dart';

final _kAnimationOpacityDuration = 50.milliseconds;
typedef XMenuController = GrockXMenuController;

class GrockXMenuOverlay extends StatefulWidget {
  final List<XMenuItem> items;
  final Size childSize;
  final Offset childOffset;
  final XMenuPositionStyle positionStyle;
  final XMenuAnimationStyle animationStyle;
  final XMenuBarrierStyle barrierStyle;
  final XMenuPopupStyle popupStyle;
  final XMenuAnimationBuilder? animationBuilder;
  final GrockXMenuController? controller;
  const GrockXMenuOverlay({
    super.key,
    required this.items,
    required this.childSize,
    required this.childOffset,
    required this.positionStyle,
    required this.animationStyle,
    required this.barrierStyle,
    required this.popupStyle,
    this.animationBuilder,
    this.controller,
  });

  @override
  State<GrockXMenuOverlay> createState() => _GrockXMenuOverlayState();
}

class _GrockXMenuOverlayState extends State<GrockXMenuOverlay>
    with SingleTickerProviderStateMixin {
  Size? widgetSize;
  Offset? widgetOffset;
  late AnimationController animationController;
  late Animation<double> translationAnimation;
  late Animation<double> rotationAnimation;

  void initialize() {
    animationController = AnimationController(
        vsync: this, duration: widget.animationStyle.duration);
    translationAnimation = translationAnimationValue;
    rotationAnimation = rotateAnimationValue;
    widget.animationBuilder?.call(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    open.widgetBinding();
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  void open() {
    Future.delayed(
      _kAnimationOpacityDuration,
      () => animationController.forward(),
    );
  }

  void close() {
    animationController.reverse();
    Future.delayed(
      animationController.duration!,
      () => Grock.closeGrockOverlay(),
    );
  }

  @override
  void initState() {
    widget.controller?._init(this);
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _(),
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Align(
            child: GrockWidgetSize(
              callback: (size, offset) => setState(() {
                widgetSize = Size(
                  widget.positionStyle.width ?? context.width * 0.4,
                  size.height,
                );
                widgetOffset = offset;
              }),
              child: AnimatedOpacity(
                duration: _kAnimationOpacityDuration,
                opacity: opacity,
                child: Transform.translate(
                  offset: transformTranslateOffset,
                  child: Transform(
                    transform: transformMatrixRotation,
                    alignment: alignment,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            widget.popupStyle.maxHeight ?? context.height * 0.4,
                      ),
                      width: widget.positionStyle.width ?? context.width * 0.4,
                      decoration: widget.popupStyle.defaultDecoration,
                      child: SingleChildScrollView(
                        child: Column(
                          children: widget.items.map<Widget>((e) {
                            return Theme(
                              data: ThemeData(
                                useMaterial3: true,
                                iconTheme: IconThemeData(
                                  size: 20,
                                  color: widget.popupStyle.defaultIconColor,
                                ),
                              ),
                              child: Padding(
                                padding: widget.popupStyle.padding,
                                child: DefaultTextStyle(
                                  style: widget.popupStyle.defaultTextStyle ??
                                      Typography.blackCupertino.bodyMedium!,
                                  child: e,
                                ),
                              ),
                            );
                          }).toListSeperated(widget.popupStyle.seperator),
                        ),
                      ),
                    ).material,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _() {
    return GestureDetector(
      onTap: widget.barrierStyle.dismissOnBarrierClick ? close : null,
      onTapDown: tapDownDetail,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
        child: ColoredBox(
          color: widget.barrierStyle.color,
          child: widget.barrierStyle.backgroundChild,
        ),
      ),
    );
  }

  void tapDownDetail(TapDownDetails details) {
    final globalOffset = details.globalPosition;
    final localOffset = details.localPosition;
    widget.barrierStyle.onBarrierClick?.call(globalOffset, localOffset);
  }

  Animation<double> get rotateAnimationValue =>
      Tween<double>(begin: 180.0, end: 0.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut));

  Animation<double> get translationAnimationValue =>
      TweenSequence(<TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
      ]).animate(animationController);

  double get blurValue =>
      translationAnimation.value * widget.barrierStyle.blurValue;

  Matrix4 get transformMatrixRotation =>
      widget.animationStyle.transformMatrixType(
          getRadiansFromDegree(rotationAnimation.value *
              widget.animationStyle.matrixRotateValue),
          translationAnimation.value);

  Offset get transformTranslateOffset => Offset.fromDirection(
        getRadiansFromDegree(180),
        translationAnimation.value * widget.animationStyle.translateOffsetValue,
      );

  double get opacity => widgetSize == null || widgetOffset == null ? 0 : 1;

  AlignmentGeometry? get alignment => _PositionCalcalute.alignment(
        context,
        widget.childSize,
        widget.childOffset,
        widgetSize ?? Size.zero,
        widgetOffset ?? Offset.zero,
        widget.positionStyle.alignment,
      );

  double? get top => widget.positionStyle.isTopSpace
      ? widget.positionStyle.top
      : _PositionCalcalute.top(context, widget.childSize, widget.childOffset,
          widgetSize ?? Size.zero, widgetOffset ?? Offset.zero);

  double? get left => widget.positionStyle.isLeftSpace
      ? widget.positionStyle.left
      : _PositionCalcalute.left(context, widget.childSize, widget.childOffset,
          widgetSize ?? Size.zero, widgetOffset ?? Offset.zero);

  double? get right =>
      widget.positionStyle.isRightSpace ? widget.positionStyle.right : null;

  double? get bottom =>
      widget.positionStyle.isBottomSpace ? widget.positionStyle.bottom : null;
}

class _PositionCalcalute {
  static double top(
    BuildContext context,
    Size childSize,
    Offset childOffset,
    Size widgetSize,
    Offset widgetOffset,
  ) {
    late double result;
    final screenHeight = context.height;
    final bottomSafeArea = screenHeight - context.bottom;
    if ((bottomSafeArea - childOffset.dy) <
        widgetSize.height + childSize.height) {
      result = childOffset.dy - widgetSize.height;
    } else {
      result = childOffset.dy + childSize.height;
    }
    return result;
  }

  static double left(
    BuildContext context,
    Size childSize,
    Offset childOffset,
    Size widgetSize,
    Offset widgetOffset,
  ) {
    late double result;
    final screenWidth = context.width;
    if ((screenWidth - childOffset.dx) < widgetSize.width + childSize.width) {
      result = childOffset.dx - widgetSize.width;
      if (result < 0) {
        if ((screenWidth / 2) > childOffset.dx) {
          result = screenWidth - widgetSize.width;
        } else {
          result = 0;
        }
      }
    } else {
      result = childOffset.dx + childSize.width;
    }
    return result;
  }

  static AlignmentGeometry alignment(BuildContext context, Size childSize,
      Offset childOffset, Size widgetSize, Offset widgetOffset,
      [AlignmentGeometry? alignment]) {
    if (alignment != null) {
      return alignment;
    } else {
      final screenHeight = context.height;
      final screenWidth = context.width;
      final childDy = childOffset.dy;
      final childDx = childOffset.dx;
      final widgetWidth = widgetSize.width;
      final widgetHeight = widgetSize.height;
      final childHeight = childSize.height;
      if (childDy + childHeight + widgetHeight >
          screenHeight - context.bottom) {
        /// [Alignment Bottom]
        if (childDx + widgetWidth < screenWidth) {
          return Alignment.bottomLeft;
        } else {
          return Alignment.bottomRight;
        }
      } else {
        /// [Alignment Top]
        if (childDx + widgetWidth < screenWidth) {
          return Alignment.topLeft;
        } else {
          return Alignment.topRight;
        }
      }
    }
  }
}

extension _GrockXMenuItemsExtension<T> on Iterable<Widget> {
  List<Widget> toListSeperated(
      Widget Function(BuildContext context, int index) seperator) {
    return toList().seperatedWidget(seperator);
  }
}
