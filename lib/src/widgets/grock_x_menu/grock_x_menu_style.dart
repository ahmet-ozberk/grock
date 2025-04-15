// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

typedef XMenuAnimationBuilder = void Function(AnimationController animCtr);

enum XMenuInkType { tap, longPress, doubleTap }

class XMenuInkStyle {
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final void Function(bool)? onFocusChange;
  final bool? autofocus;
  final WidgetStatesController? statesController;
  final XMenuInkType inkType;

  const XMenuInkStyle(
      {this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.overlayColor,
      this.splashColor,
      this.splashFactory,
      this.radius,
      this.borderRadius,
      this.customBorder,
      this.enableFeedback = true,
      this.focusNode,
      this.canRequestFocus = true,
      this.onFocusChange,
      this.autofocus,
      this.statesController,
      this.inkType = XMenuInkType.tap});
}

class XMenuPositionStyle {
  final bool isTopSpace;
  final bool isLeftSpace;
  final bool isRightSpace;
  final bool isBottomSpace;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final AlignmentGeometry? alignment;
  final double? width;
  const XMenuPositionStyle({
    this.isTopSpace = false,
    this.isLeftSpace = false,
    this.isRightSpace = false,
    this.isBottomSpace = false,
    this.top,
    this.left,
    this.right,
    this.bottom,

    /// Alignment calculate by [XMenuPositionStyle.top] and [XMenuPositionStyle.left]
    this.alignment,

    /// Default value is 40% of the screen width
    this.width,
  });
}

class XMenuAnimationStyle {
  final Duration duration; // default 250 milliseconds
  final Animation<double>? translationAnimation;
  final Animation<double>? rotationAnimation;
  final Curve rotationCurve; // default Curves.easeOut
  final Duration delayDuration; // default 0 milliseconds
  final double translateOffsetValue; // default 0
  final double matrixRotateValue; // default 1
  final Matrix4 Function(double value, double scaleValue) transformMatrixType;

  const XMenuAnimationStyle({
    this.duration = const Duration(milliseconds: 300),
    this.translationAnimation,
    this.rotationAnimation,
    this.rotationCurve = Curves.easeOut,
    this.delayDuration = const Duration(milliseconds: 0),
    this.translateOffsetValue = 1,
    this.matrixRotateValue = 0.6,
    this.transformMatrixType = defaultTransformMatrixRotation,
  });

  static Matrix4 defaultTransformMatrixRotation(
      double value, double scaleValue) {
    return Matrix4.rotationX(value)..rotateY(value)..scale(scaleValue);
  }
}

class XMenuBarrierStyle {
  final double blurValue; // default 1
  final Color color; // default Colors.black12
  final Widget? backgroundChild;
  final bool dismissOnBarrierClick; // default true
  final Function(Offset globalPosition, Offset localPosition)? onBarrierClick;
  const XMenuBarrierStyle({
    this.blurValue = 1,
    this.color = Colors.transparent,
    this.backgroundChild,
    this.dismissOnBarrierClick = true,
    this.onBarrierClick,
  });
}

class XMenuItemStyle {
  final BoxFit labelFit; // default BoxFit.none
  final BorderRadius? borderRadius; // default BorderRadius.circular(0)
  const XMenuItemStyle({
    this.labelFit = BoxFit.none,
    this.borderRadius,
  });
}

class XMenuPopupStyle {
  final BoxDecoration? decoration;
  final Widget Function(BuildContext, int) seperator;
  final TextStyle? defaultTextStyle;
  final EdgeInsetsGeometry padding;
  final double? maxHeight;
  final Color? defaultIconColor;
  const XMenuPopupStyle({
    this.decoration,
    this.seperator = defaultSeperator,

    /// Default value is [Typography.blackCupertino.bodyMedium]
    this.defaultTextStyle, 

    /// Default value is 8.padding
    this.padding = const EdgeInsets.all(8),

    /// Default value is 40% of the screen height
    this.maxHeight,

    /// Default value is [ThemeData.iconTheme.color]
    this.defaultIconColor,
  });

  static Widget defaultSeperator(BuildContext context, int index) {
    return const Divider(height: 0);
  }

  BoxDecoration get defaultDecoration =>
      decoration ??
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 0.04,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(-10, 14),
          ),
        ],
      );
}
