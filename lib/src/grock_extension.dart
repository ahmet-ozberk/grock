library grock_extension;

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:grock/src/model/loading_widget.dart';
import 'model/navigation_state.dart';
import 'model/scaffold_messenger.dart';
import 'package:flutter/cupertino.dart';

part 'widgets/grock_toast.dart';
part 'components/grock_overlay.dart';
part 'widgets/grock_fullscreen_dialog.dart';
part 'snackbar/grock_snackbar.dart';

extension Grock on ScaffoldMessengerModel {
  /// [Keys]

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      ScaffoldMessengerModel.scaffoldMessengerKey;
  static GlobalKey<NavigatorState> get navigationKey =>
      NavigationService.navigationKey;

  /// [Context]

  static BuildContext get context =>
      NavigationService.navigationKey.currentContext!;

  /// [Device Information]

  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;
  static bool get isWindows => Platform.isWindows;
  static bool get isFuchsia => Platform.isFuchsia;

  /// [Device Screen Size]

  static double get deviceWidth => View.of(context).physicalSize.width;
  static double get deviceHeight => View.of(context).physicalSize.height;
  static Size get deviceSize => View.of(context).physicalSize;

  static double get height => ScaffoldMessengerModel.height;
  static double get width => ScaffoldMessengerModel.width;
  static Offset get topCenter => ScaffoldMessengerModel.topCenter;
  static Offset get bottomCenter => ScaffoldMessengerModel.bottomCenter;
  static Offset get center => ScaffoldMessengerModel.center;
  static Offset get topLeft => ScaffoldMessengerModel.topLeft;
  static Offset get topRight => ScaffoldMessengerModel.topRight;
  static Offset get bottomLeft => ScaffoldMessengerModel.bottomLeft;
  static Offset get bottomRight => ScaffoldMessengerModel.bottomRight;
  static Offset get centerLeft => ScaffoldMessengerModel.centerLeft;
  static Offset get centerRight => ScaffoldMessengerModel.centerRight;

  /// [Navigation]

  static Future to(
    Widget page, {
    NavType? type,
    Widget? childCurrent,
    BuildContext? ctx,
    bool inheritTheme = false,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
    bool opaque = false,
  }) {
    log("Navigation to $page", name: "Grock");
    return NavigationService.to(page,
        type: type,
        childCurrent: childCurrent,
        ctx: ctx,
        inheritTheme: inheritTheme,
        curve: curve,
        alignment: alignment,
        duration: duration,
        reverseDuration: reverseDuration,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque);
  }

  static Future toRemove(
    Widget page, {
    NavType? type,
    Widget? childCurrent,
    BuildContext? ctx,
    bool inheritTheme = false,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
    bool opaque = false,
  }) {
    log("Navigation toRemove $page", name: "Grock");
    return NavigationService.toRemove(page,
        type: type,
        childCurrent: childCurrent,
        ctx: ctx,
        inheritTheme: inheritTheme,
        curve: curve,
        alignment: alignment,
        duration: duration,
        reverseDuration: reverseDuration,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque);
  }

  static void back({Object? result}) {
    log("Navigation back", name: "Grock");
    NavigationService.back(result: result);
  }

  static void hideKeyboard() =>
      FocusScope.of(context).requestFocus(FocusNode());
  static void widgetBinding(Function function) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => function());

  /// [Snackbar]

  static void snackBar({
    required String title,
    required String description,
    Color? color,
    Function()? onTap,
    Widget? body,
    SnackbarPosition position = SnackbarPosition.top,
    Duration duration = const Duration(seconds: 4),
    Curve curve = Curves.fastLinearToSlowEaseIn,
    BorderRadiusGeometry? borderRadius,
    double? blur,
    Duration openDuration = const Duration(milliseconds: 600),
    double? opacity,
    double? width,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? leadingPadding,
    EdgeInsetsGeometry? trailingPadding,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? descriptionPadding,
    Widget? leading,
    Widget? trailing,
    double? itemSpaceHeight,
    Color? titleColor,
    Color? descriptionColor,
    double? titleSize,
    double? descriptionSize,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    BoxBorder? border,
  }) =>
      _GrockSnackbar.showSnackbar(
        borderRadius: borderRadius,
        duration: duration,
        onTap: onTap,
        position: position,
        curve: curve,
        blur: blur,
        body: body,
        openDuration: openDuration,
        opacity: opacity,
        color: color,
        width: width,
        padding: padding,
        margin: margin,
        leadingPadding: leadingPadding,
        trailingPadding: trailingPadding,
        leading: leading,
        trailing: trailing,
        itemSpaceHeight: itemSpaceHeight,
        title: title,
        description: description,
        titleColor: titleColor,
        descriptionColor: descriptionColor,
        titleSize: titleSize,
        descriptionSize: descriptionSize,
        titleStyle: titleStyle,
        descriptionStyle: descriptionStyle,
        border: border,
        descriptionPadding: descriptionPadding,
        titlePadding: titlePadding,
      );

  static void fullScreenModal({
    required Widget Function(BuildContext, Animation<double>, Animation<double>)
        builder,
    bool isSlideTransition = true,
    bool isScaleTransition = false,
    bool isFadeTranssition = true,
    bool isRotateTransition = false,
    Alignment scaleAlignment = Alignment.topCenter,
    SlideTransitionType slideTransitionType = SlideTransitionType.fromTop,
    Duration openDuration = const Duration(milliseconds: 500),
    bool isOpaque = false,
    bool isBarrierDismissible = false,
    Color barrierColorValue = Colors.black54,
    String? barrierLabelValue,
    bool isMaintainState = true,
  }) {
    Navigator.push(
        context,
        GrockFullScreenModal(
          builder: builder,
          isSlideTransition: isSlideTransition,
          isScaleTransition: isScaleTransition,
          isFadeTranssition: isFadeTranssition,
          isRotateTransition: isRotateTransition,
          scaleAlignment: scaleAlignment,
          slideTransitionType: slideTransitionType,
          openDuration: openDuration,
          isOpaque: isOpaque,
          isBarrierDismissible: isBarrierDismissible,
          barrierColorValue: barrierColorValue,
          barrierLabelValue: barrierLabelValue,
          isMaintainState: isMaintainState,
        ));
  }

  static void fullScreenDialog({
    required Widget child,
    Duration openDuration = const Duration(milliseconds: 600),
    Duration closeDuration = const Duration(milliseconds: 300),
    Tween<double>? closeTween,
    bool isCloseScaleAnimation = false,
    //bool isMatrixAnimation = false,
    bool isHorizontalSlideAnimation = true,
    double closureRate = 0.24,
    Alignment openAlignment = Alignment.bottomLeft,
    Alignment closeAlignment = Alignment.bottomLeft,
    bool isSlideOpacity = true,
    int matrixRotateValue = 1000,
    Key? key,
  }) {
    showGrockOverlay(
      child: _GrockFullScreenDialog(
        child: child,
        openDuration: openDuration,
        closeDuration: closeDuration,
        closeTween: closeTween,
        isCloseScaleAnimation: isCloseScaleAnimation,
        //isMatrixAnimation: isMatrixAnimation,
        isHorizontalSlideAnimation: isHorizontalSlideAnimation,
        closureRate: closureRate,
        openAlignment: openAlignment,
        closeAlignment: closeAlignment,
        isSlideOpacity: isSlideOpacity,
        matrixRotateValue: matrixRotateValue,
        key: key,
      ),
    );
  }

  static bool get isOpenSnackbar => _GrockSnackbar.isShowing;
  // static void closeSnackbar() {
  //   GrockSnackbar.overlayEntry?.remove();
  //   GrockSnackbar.overlayEntry = null;
  // }
  static double normalizeValue(double value, double minValue, double maxValue) {
    return (value - minValue) / (maxValue - minValue);
  }

  static bool isDarkTheme = Grock.context.isDarkTheme;

  static void dialog({
    required Widget Function(BuildContext grockContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      _GrockSnackbar.dialog(
          builder: builder,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          barrierLabel: barrierLabel,
          useSafeArea: useSafeArea,
          useRootNavigator: useRootNavigator,
          routeSettings: routeSettings);

  static void toast({
    /// [text] or [child] or [widget] must be required
    String? text,

    /// [child] or [widget] must be required
    Widget? child,

    /// [child] or [text] must be required
    Widget? widget,

    /// toast position [Alignment.topCenter] or [Alignment.bottomCenter]
    AlignmentGeometry alignment = Alignment.bottomCenter,

    ///toast curve [Curves.bounceOut]
    Curve curve = Curves.bounceOut,

    /// toast tap event
    Function? onTap,

    /// toast duration [Duration(seconds: 4)]
    Duration? duration,

    /// toast open duration [Duration(milliseconds: 600)]
    Duration openDuration = const Duration(milliseconds: 600),

    /// toast border radius [BorderRadius.circular(10)]
    BorderRadiusGeometry? borderRadius,

    /// toast padding [EdgeInsets.all(10)]
    EdgeInsetsGeometry? padding,

    /// toast margin [EdgeInsets.all(10)]
    EdgeInsetsGeometry? margin,

    /// toast background color [Colors.black54]
    Color? backgroundColor,

    /// toast text color [Colors.white]
    Color? textColor,

    /// toast box shadow [BoxShadow(color: Colors.black54, blurRadius: 10)]
    List<BoxShadow>? boxShadow,

    /// toast text style [TextStyle(fontSize: 14)]
    TextStyle? textStyle,

    /// toast width [double.infinity]
    BoxBorder? border,

    /// toast width [double.infinity]
    double? width,

    /// toast text align [TextAlign.center]
    TextAlign textAlign = TextAlign.center,

    /// toast text overflow [TextOverflow.clip]
    TextOverflow overflow = TextOverflow.clip,

    /// toast text max lines [2]
    int? maxLines,
  }) {
    OverlayState overlayState = Grock.navigationKey.currentState!.overlay!;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return _GrockToastWidget(
          overlayEntry: overlayEntry,
          text: text,
          onTap: onTap,
          widget: widget,
          openDuration: openDuration,
          borderRadius: borderRadius,
          padding: padding,
          margin: margin,
          backgroundColor: backgroundColor,
          textColor: textColor,
          boxShadow: boxShadow,
          textStyle: textStyle,
          alignment: alignment,
          width: width,
          curve: curve,
          duration: duration,
          border: border,
          child: child,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
        );
      },
    );
    overlayState.insert(overlayEntry);
  }

  /// [Grock Overlay] show and close
  static void showGrockOverlay({required Widget child}) {
    _GrockOverlay.show(child: child);
  }

  /// [Grock Overlay] is open
  static bool isOpenGrockOverlay() => _GrockOverlay.isOpen;

  /// [Grock Overlay] close
  static void closeGrockOverlay() => _GrockOverlay.close();

  /// [Empty Widget]
  static Widget get empty => SizedBox.shrink();

  /// [Random Color] from [Colors.primaries]
  static Color rndColor() =>
      Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  /// [Random Color] from [Colors.primaries]
  static Color randomColor() => Colors.primaries[17.randomNum];

  /// [Grock Internet Checker] check internet
  static void checkInternet({
    Function()? onConnect,
    Function()? onDisconnect,
    Color? connectBackgroundColor,
    Color? connectIconColor,
    Icon? connectIcon,
    Widget? connectWidget,
    Duration connectWidgetDuration = const Duration(seconds: 2),
    Widget? disconnectWidget,
    Color? disconnectBackgroundColor,
    Color? disconnectIconColor,
    Icon? disconnectIcon,
    AlignmentGeometry? alignment,
    BoxShape? shape,
  }) {
    GrockInternetChecker.internetCheckFunction(
      onConnect: onConnect,
      onDisconnect: onDisconnect,
      connectBackgroundColor: connectBackgroundColor,
      connectIconColor: connectIconColor,
      connectIcon: connectIcon,
      connectWidget: connectWidget,
      connectWidgetDuration: connectWidgetDuration,
      disconnectWidget: disconnectWidget,
      disconnectBackgroundColor: disconnectBackgroundColor,
      disconnectIconColor: disconnectIconColor,
      disconnectIcon: disconnectIcon,
      alignment: alignment,
      shape: shape,
    );
  }

  static Widget loadingPopup(
          {Key? key,
          Color? backgroundColor,
          String? text,
          Widget? child,
          TextStyle? style,
          Color? color,
          double? height,
          double? width,
          BorderRadiusGeometry? borderRadius,
          bool isScale = true,
          double strokeWidth = 4,
          double startScale = 1.0,
          double endScale = 0.6,
          Gradient? gradient}) =>
      GrockCustomLoadingWidget(
        backgroundColor: backgroundColor,
        child: child,
        startScale: startScale,
        isScale: isScale,
        height: height,
        width: width,
        key: key,
        strokeWidth: strokeWidth,
        endScale: endScale,
        color: color,
        borderRadius: borderRadius,
        text: text,
        textStyle: style,
        gradient: gradient,
      );
}
