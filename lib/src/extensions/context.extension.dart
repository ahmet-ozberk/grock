import 'package:flutter/material.dart';
import 'int.extension.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get accentColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get dividerColor => Theme.of(this).dividerColor;
  Color get focusColor => Theme.of(this).focusColor;
  Color get hoverColor => Theme.of(this).hoverColor;
  Color get highlightColor => Theme.of(this).highlightColor;
  Color get splashColor => Theme.of(this).splashColor;
  Color get unselectedWidgetColor => Theme.of(this).unselectedWidgetColor;
  Color get disabledColor => Theme.of(this).disabledColor;
  Color get buttonColor => Theme.of(this).buttonTheme.colorScheme!.primary;
  Color get secondaryHeaderColor => Theme.of(this).secondaryHeaderColor;
  Color get indicatorColor => Theme.of(this).indicatorColor;
  Color get hintColor => Theme.of(this).hintColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get scaffoldDarkBackgroundColor => ThemeData.dark(useMaterial3: true).scaffoldBackgroundColor;
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDarkTheme => brightness == Brightness.dark;
}

extension SizeExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => MediaQuery.of(this).size;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get heightRatio => MediaQuery.of(this).size.height / 100;
  double get widthRatio => MediaQuery.of(this).size.width / 100;
  double get top => MediaQuery.of(this).padding.top;
  double get bottom => MediaQuery.of(this).padding.bottom;
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get safeAreaHeight =>
      MediaQuery.of(this).size.height -
      MediaQuery.of(this).padding.top -
      MediaQuery.of(this).padding.bottom;

  double aspectRatio(double width, double height) =>
      MediaQuery.of(this).size.width / width * height;

  EdgeInsets get bottomSheetKeyboardPadding => MediaQuery.of(this).viewInsets;

  double get bottomSheetKeyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  double get bottomSheetKeyboardHeightRatio =>
      MediaQuery.of(this).viewInsets.bottom / 100;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  EdgeInsets get keyboardPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get mediaQueryShortestSide => size.shortestSide;

  bool get isPhone => (mediaQueryShortestSide < 600);

  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  bool get isTablet => isSmallTablet || isLargeTablet;

  bool get isDesktop => (mediaQueryShortestSide >= 900);

  TextTheme get textTheme => Theme.of(this).textTheme;


  TargetPlatform get platform => Theme.of(this).platform;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
          SnackBar snackbar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackbar);

  void removeCurrentSnackBar(
          {SnackBarClosedReason reason = SnackBarClosedReason.remove}) =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar(reason: reason);

  void hideCurrentSnackBar(
          {SnackBarClosedReason reason = SnackBarClosedReason.hide}) =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar(reason: reason);

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void openKeyboard() => FocusManager.instance.primaryFocus?.requestFocus();

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  void showBottomSheet(
    WidgetBuilder builder, {
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehaviour,
  }) =>
      Scaffold.of(this).showBottomSheet(
        builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehaviour,
      );
}

extension ColorExtension on BuildContext {
  Color get randomColor => Colors.primaries[17.randomNum];
}

class _FocusScope {
  const _FocusScope(this._context);

  final BuildContext _context;

  FocusScopeNode _node() => FocusScope.of(_context);

  bool get hasFocus => _node().hasFocus;

  bool get isFirstFocus => _node().isFirstFocus;

  bool get hasPrimaryFocus => _node().hasPrimaryFocus;

  bool get canRequestFocus => _node().canRequestFocus;

  void nextFocus() => _node().nextFocus();

  void requestFocus([FocusNode? node]) => _node().requestFocus(node);

  void previousFocus() => _node().previousFocus();

  void unfocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) =>
      _node().unfocus(disposition: disposition);

  void setFirstFocus(FocusScopeNode scope) => _node().setFirstFocus(scope);

  bool consumeKeyboardToken() => _node().consumeKeyboardToken();
}

class _Form {
  _Form(this._context);

  final BuildContext _context;

  bool validate() => Form.of(_context).validate();

  void reset() => Form.of(_context).reset();

  void save() => Form.of(_context).save();
}

extension FormExt on BuildContext {
  _Form get form => _Form(this);
}

extension FocusScopeExt on BuildContext {
  _FocusScope get focusScope => _FocusScope(this);

  void closeKeyboard() => this.focusScope.requestFocus(FocusNode());
}
