library grock_extension;

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:grock/src/model/loading_widget.dart';
import 'package:flutter/cupertino.dart';

part 'widgets/grock_toast.dart';
part 'components/grock_overlay.dart';
part 'widgets/grock_fullscreen_dialog.dart';
part 'snackbar/grock_snackbar.dart';
part 'widgets/grock_adaptive_dialog_button.dart';

class Grock {
  Grock._();

  /// ScaffoldMessengerKey for show snackbar
  /// Added in MaterialApp => scaffoldMessengerKey: Grock.scaffoldMessengerKey,
  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      GrockScaffoldMessengerService.scaffoldMessengerKey;

  /// NavigationKey for navigation
  /// Added in MaterialApp => navigatorKey: Grock.navigationKey,
  /// Grock Navigation, extensions, and more features are available in this key
  static GlobalKey<NavigatorState> get navigationKey =>
      GrockNavigationService.navigationKey;

  /// [Context] for get context
  static BuildContext get context =>
      GrockNavigationService.navigationKey.currentContext!;

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

  static double get height => GrockScaffoldMessengerService.height;
  static double get width => GrockScaffoldMessengerService.width;

  /// [Navigation]
  /// ```dart
  /// Grock.to(
  ///  HomeScreen(),
  ///  type: NavType.fade,
  ///  duration: Duration(milliseconds: 600),
  ///  fullscreenDialog: false,
  /// );
  static Future to(
    Widget page, {
    NavType? type,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    log("Navigation to $page", name: "Grock");
    return GrockNavigationService.to(
      page,
      type: type,
      duration: duration,
      fullscreenDialog: fullscreenDialog,
    ).catchError((err) {
      log("$err", name: "Grock.to($page) error!", error: err);
    });
  }

  /// ```dart
  /// Grock.toRemove(
  ///  HomeScreen(),
  ///  type: NavType.fade,
  ///  duration: Duration(milliseconds: 600),
  /// );
  static Future toRemove(
    Widget page, {
    NavType? type,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    log("Navigation toRemove $page", name: "Grock");
    return GrockNavigationService.toRemove(
      page,
      type: type,
      duration: duration,
      fullscreenDialog: fullscreenDialog,
    ).catchError((err) {
      log("$err", name: "Grock.to($page) error!", error: err);
    });
  }

  /// ```dart
  /// Grock.back(result: "Result String Data");
  static void back({Object? result}) {
    log("Navigation back", name: "Grock");
    GrockNavigationService.back(result: result);
  }

  /// Hide keyboard function.
  static void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();
  static void widgetBinding(Function function) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => function());

  /// The best snackbar widget
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
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 15,
    ),
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
  }) => _GrockSnackbar.showSnackbar(
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

  static void showMaterialBanner({
    Key? key,
    required Widget content,
    TextStyle? contentTextStyle,
    List<Widget>? actions,
    double? elevation,
    Widget? leading,
    Color? backgroundColor,
    Color? surfaceTintColor,
    Color? shadowColor,
    Color? dividerColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? leadingPadding,
    bool forceActionsBelow = false,
    OverflowBarAlignment overflowAlignment = OverflowBarAlignment.end,
    Animation<double>? animation,
    void Function()? onVisible,
  }) {
    scaffoldMessengerKey.currentState?.showMaterialBanner(
      MaterialBanner(
        key: key,
        content: content,
        contentTextStyle: contentTextStyle,
        actions: actions ?? [],
        elevation: elevation,
        leading: leading,
        backgroundColor: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        shadowColor: shadowColor,
        dividerColor: dividerColor,
        padding: padding,
        margin: margin,
        leadingPadding: leadingPadding,
        forceActionsBelow: forceActionsBelow,
        overflowAlignment: overflowAlignment,
        animation: animation,
        onVisible: onVisible,
      ),
    );
  }

  static void clearMaterialBanner() {
    scaffoldMessengerKey.currentState?.clearMaterialBanners();
  }

  static Future<T?> fullScreenModal<T extends Object?>({
    required Widget Function(BuildContext, Animation<double>, Animation<double>)
    builder,
    bool isSlideTransition = true,
    bool isScaleTransition = false,
    bool isFadeTranssition = true,
    bool isRotateTransition = false,
    bool isVerticalGestureClose = false,
    Alignment scaleAlignment = Alignment.topCenter,
    SlideTransitionType slideTransitionType = SlideTransitionType.fromTop,
    Duration openDuration = const Duration(milliseconds: 500),
    bool isOpaque = false,
    bool isBarrierDismissible = false,
    Color barrierColorValue = Colors.black54,
    String? barrierLabelValue,
    bool isMaintainState = true,
  }) async {
    return await Navigator.push<T>(
      context,
      GrockFullScreenModal<T>(
        builder: builder,
        isSlideTransition: isSlideTransition,
        isScaleTransition: isScaleTransition,
        isFadeTranssition: isFadeTranssition,
        isRotateTransition: isRotateTransition,
        isVerticalGestureClose: isVerticalGestureClose,
        scaleAlignment: scaleAlignment,
        slideTransitionType: slideTransitionType,
        openDuration: openDuration,
        isOpaque: isOpaque,
        isBarrierDismissible: isBarrierDismissible,
        barrierColorValue: barrierColorValue,
        barrierLabelValue: barrierLabelValue,
        isMaintainState: isMaintainState,
      ),
    );
  }

  static void fullScreenDialog({
    required Widget child,
    Duration openDuration = const Duration(milliseconds: 600),
    Duration closeDuration = const Duration(milliseconds: 300),
    Tween<double>? closeTween,
    bool isCloseScaleAnimation = false,
    bool isMatrixAnimation = false,
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
        isMatrixAnimation: isMatrixAnimation,
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

  /// Grock.normalizeValue(10, 0, 100).printer; normalize value
  static double normalizeValue(double value, double minValue, double maxValue) {
    return (value - minValue) / (maxValue - minValue);
  }

  static bool isDarkTheme = Grock.context.isDarkTheme;

  static Future<T?> dialog<T>({
    required Widget Function(BuildContext grockContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) async => await _GrockSnackbar.dialog(
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );

  /// Toast widget, no context required
  /// ```dart
  /// Grock.toast(
  ///  text: "Hello World",
  ///  alignment: Alignment.topCenter,
  ///  curve: Curves.bounceOut,
  ///  duration: Duration(seconds: 4),
  ///  openDuration: Duration(milliseconds: 600),
  ///  borderRadius: BorderRadius.circular(10),
  ///  padding: EdgeInsets.all(10),
  ///  margin: EdgeInsets.all(10),
  ///  backgroundColor: Colors.black54,
  ///  textColor: Colors.white,
  ///  boxShadow: [
  ///   BoxShadow(color: Colors.black54, blurRadius: 10)
  ///  ],
  ///  textStyle: TextStyle(fontSize: 14),
  ///  width: double.infinity,
  ///  border: Border.all(color: Colors.white),
  /// );
  /// ```
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

  /// [Grock Overlay] show overlay widget
  static void showGrockOverlay({required Widget child}) {
    _GrockOverlay.show(child: child);
  }

  /// [Grock Overlay] is open or not
  static bool isOpenGrockOverlay() => _GrockOverlay.isOpen;

  /// [Grock Overlay] close overlay
  static void closeGrockOverlay() => _GrockOverlay.close();

  /// [Empty Widget]
  static Widget get empty => SizedBox.shrink();

  /// [Random Color] from [Colors.primaries]
  static Color rndColor() =>
      Color((random.nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: .0);

  /// [Random Color] from [Colors.primaries]
  static Color randomColor() => Colors.primaries[17.randomNum];

  // /// [Grock Internet Checker] check internet connection and show widget
  // static void checkInternet({
  //   Function()? onConnect,
  //   Function()? onDisconnect,
  //   Color? connectBackgroundColor,
  //   Color? connectIconColor,
  //   Icon? connectIcon,
  //   Widget? connectWidget,
  //   Duration connectWidgetDuration = const Duration(seconds: 2),
  //   Widget? disconnectWidget,
  //   Color? disconnectBackgroundColor,
  //   Color? disconnectIconColor,
  //   Icon? disconnectIcon,
  //   AlignmentGeometry? alignment,
  //   BoxShape? shape,
  // }) {
  //   GrockInternetChecker.internetCheckFunction(
  //     onConnect: onConnect,
  //     onDisconnect: onDisconnect,
  //     connectBackgroundColor: connectBackgroundColor,
  //     connectIconColor: connectIconColor,
  //     connectIcon: connectIcon,
  //     connectWidget: connectWidget,
  //     connectWidgetDuration: connectWidgetDuration,
  //     disconnectWidget: disconnectWidget,
  //     disconnectBackgroundColor: disconnectBackgroundColor,
  //     disconnectIconColor: disconnectIconColor,
  //     disconnectIcon: disconnectIcon,
  //     alignment: alignment,
  //     shape: shape,
  //   );
  // }

  static Widget loadingPopup({
    Key? key,
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
    Gradient? gradient,
  }) => GrockCustomLoadingWidget(
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

  /// Grock.uniqId(length: 11).printer; generate uniq id
  /// Response => ```dart 34576890876 ```
  static String uniqId({
    int length = 11,
    GrockUniqIdType type = GrockUniqIdType.numbers,
  }) => GrockUniqIdServices.generate(
    length: length,
    type: GrockUniqIdType.numbers,
  );

  /// ------ Grock Widget Extensions ------
  /// * This widget function is available in [actions] in [AlertDialog.adaptive].
  /// ```dart
  /// showAdaptiveDialog(
  ///   context: context,
  ///   builder: (context) {
  ///     return AlertDialog.adaptive(
  ///       title: const Text("Please Confrm"),
  ///       content: const Text("Do you agree with our terms?"),
  ///       actions: [
  ///        Grock.adaptiveDialogButton(
  ///           onPressed: () => Navigator.of(context).pop(),
  ///           isDefaultAction: true,
  ///           isDestructiveAction: true,
  ///           child: Text("No"),
  ///         ),
  ///         Grock.adaptiveDialogButton(
  ///           onPressed: ...,
  ///           child: Text("Yes"),
  ///         )
  ///       ],
  ///     );
  ///   },
  /// );
  /// ```
  static Widget adaptiveDialogButton({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    bool isDefaultAction = false,
    bool isDestructiveAction = false,
  }) => GrockAdaptiveDialogButton(
    key: key,
    child: child,
    onPressed: onPressed,
    isDefaultAction: isDefaultAction,
    isDestructiveAction: isDestructiveAction,
  );
}
