import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:grock/src/model/loading_widget.dart';
import 'model/navigation_state.dart';
import 'model/scaffoldMessenger.dart';
import 'package:flutter/cupertino.dart';

part 'widgets/grock_toast.dart';
part 'components/grock_overlay.dart';

extension Grock on ScaffoldMessengerModel {
  /// [Keys]

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey => ScaffoldMessengerModel.scaffoldMessengerKey;
  static GlobalKey<NavigatorState> get navigationKey => NavigationService.navigationKey;

  /// [Context]

  static BuildContext get context => NavigationService.navigationKey.currentContext!;

  /// [Device Information]

  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;
  static bool get isWindows => Platform.isWindows;
  static bool get isFuchsia => Platform.isFuchsia;

  /// [Device Screen Size]

  static double get deviceWidth => window.physicalSize.width;
  static double get deviceHeight => window.physicalSize.height;
  static Size get deviceSize => window.physicalSize;

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

  static void hideKeyboard() => FocusScope.of(context).requestFocus(FocusNode());
  static void widgetBinding(Function function) => WidgetsBinding.instance.addPostFrameCallback((_) => function());

  /// [Snackbar]

  static void snackBar({
    required String title,
    required String description,
    Color? color,
    Widget? body,
    SnackbarPosition position = SnackbarPosition.top,
    Duration duration = const Duration(seconds: 4),
    Curve curve = Curves.fastLinearToSlowEaseIn,
    BorderRadiusGeometry? borderRadius,
    double? blur,
    Duration openDuration = const Duration(milliseconds: 600),
    double? opacity,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      GrockSnackbar.showSnackbar(
        borderRadius: borderRadius,
        duration: duration,
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

  static bool get isOpenSnackbar => GrockSnackbar.isShowing;
  // static void closeSnackbar() {
  //   GrockSnackbar.overlayEntry?.remove();
  //   GrockSnackbar.overlayEntry = null;
  // }

  static void dialog({
    required Widget Function(BuildContext grockContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      GrockSnackbar.dialog(
          builder: builder,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          barrierLabel: barrierLabel,
          useSafeArea: useSafeArea,
          useRootNavigator: useRootNavigator,
          routeSettings: routeSettings);

  static void toast({
    String? text,
    Widget? child,
    AlignmentGeometry alignment = Alignment.bottomCenter,
    Curve curve = Curves.bounceOut,
    Function? onTap,
    Duration? duration,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    ToastTheme? theme,
    Color? backgroundColor,
    Color? textColor,
    List<BoxShadow>? boxShadow,
    TextStyle? textStyle,
    BoxBorder? border,
    double? width,
    TextAlign textAlign = TextAlign.center,
    TextOverflow overflow = TextOverflow.clip,
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
          borderRadius: borderRadius,
          padding: padding,
          margin: margin,
          theme: theme,
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

  static void showGrockOverlay({required Widget child}) {
    _GrockOverlay.show(child: child);
  }

  static bool isOpenGrockOverlay() => _GrockOverlay.isOpen;
  static void closeGrockOverlay() => _GrockOverlay.close();

  /// [Empty Widget]

  static Widget get empty => SizedBox.shrink();

  /// [Internet Check]
  static Color rndColor() => Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  static Color randomColor() => Colors.primaries[17.randomNum];

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
          double endScale = 0.6,Gradient? gradient}) =>
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
