import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'enum/toast_enum.dart';
import 'model/navigation_state.dart';
import 'model/scaffoldMessenger.dart';
import 'widgets/grock_toast.dart';

extension Grock on ScaffoldMessengerModel {
  /// [Keys]

  static get scaffoldMessengerKey =>
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

  static double get deviceWidth => window.physicalSize.width;
  static double get deviceHeight => window.physicalSize.height;

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

  static Future to(Widget page, {NavType? type}) {
    log("Navigation to $page", name: "Grock");
    return NavigationService.to(page, type: type);
  }

  static Future toRemove(Widget page, {NavType? type}) {
    log("Navigation toRemove $page", name: "Grock");
    return NavigationService.toRemove(page, type: type);
  }

  static void back({Object? result}) {
    log("Navigation back", name: "Grock");
    NavigationService.back(result: result);
  }

  /// [Snackbar]

  static void snackBar({
    required String title,
    required String description,
    Color? color,
    SnackbarPosition position = SnackbarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Curve curve = Curves.fastLinearToSlowEaseIn,
    double? borderRadius,
    double? blur,
    Duration openDuration = const Duration(milliseconds: 800),
    double? opacity,
    double? width,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
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

  static void dialog({
    required Widget Function(BuildContext) builder,
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
    Curve curve = Curves.easeInOutCubicEmphasized,
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
        return GrockToastWidget(
          overlayEntry: overlayEntry,
          text: text,
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

  /// [Empty Widget]

  static Widget get empty => SizedBox.shrink();

  /// [Internet Check]

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
}
