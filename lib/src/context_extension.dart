import 'package:flutter/material.dart';
import 'int_extension.dart';

extension SizeExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => MediaQuery.of(this).size;
  double get top => MediaQuery.of(this).padding.top;
  double get bottom => MediaQuery.of(this).padding.bottom;
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  TextStyle? get headline1 => textTheme.headline1;

  TextStyle? get headline2 => textTheme.headline2;

  TextStyle? get headline3 => textTheme.headline3;

  TextStyle? get headline4 => textTheme.headline4;

  TextStyle? get headline5 => textTheme.headline5;

  TextStyle? get headline6 => textTheme.headline6;

  TextStyle? get subtitle1 => textTheme.subtitle1;

  TextStyle? get bodyText1 => textTheme.bodyText1;

  TextStyle? get bodyText2 => textTheme.bodyText2;

  TextStyle? get caption => textTheme.caption;

  TextStyle? get button => textTheme.button;

  TextStyle? get subtitle2 => textTheme.subtitle2;

  TextStyle? get overline => textTheme.overline;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  double get mediaQueryShortestSide => size.shortestSide;

  /// True if the current device is Phone
  bool get isPhone => (mediaQueryShortestSide < 600);

  /// 600dp: a 7” tablet (600x1024 mdpi).
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// 720dp: a 10” tablet (720x1280 mdpi, 800x1280 mdpi, etc).
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;

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

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  void showBottomSheet(WidgetBuilder builder,
          {Color? backgroundColor,
          double? elevation,
          ShapeBorder? shape,
          Clip? clipBehaviour}) =>
      Scaffold.of(this).showBottomSheet(builder,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          clipBehavior: clipBehaviour);
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

  bool validate() => Form.of(_context)!.validate();

  void reset() => Form.of(_context)!.reset();

  void save() => Form.of(_context)!.save();
}

extension FormExt on BuildContext {
  _Form get form => _Form(this);
}

extension FocusScopeExt on BuildContext {
  _FocusScope get focusScope => _FocusScope(this);

  void closeKeyboard() => this.focusScope.requestFocus(FocusNode());
}
