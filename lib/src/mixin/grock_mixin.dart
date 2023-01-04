// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// [Grock Mixin]
/// This mixin is used to add grock functionality to a class.

mixin GrockMixin<T extends StatefulWidget> on State<T> {
  /// Dynamic [setState] method
  void setStateIfMounted(void Function() fn) {
    if (mounted) setState(fn);
  }

  /// [showSnackBar] method
  void showGrockSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// [showSnackBar] method
  void showGrockSnackBarWithAction(
    String message, {
    Duration? duration,
    required String actionLabel,
    required VoidCallback action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
        action: SnackBarAction(
          label: actionLabel,
          onPressed: action,
        ),
      ),
    );
  }

  /// [showSnackBar] method
  void showGrockSnackBarWithActionAndIcon(
    String message, {
    Duration? duration,
    required String actionLabel,
    required VoidCallback action,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
        duration: duration ?? const Duration(seconds: 2),
        action: SnackBarAction(
          label: actionLabel,
          onPressed: action,
        ),
      ),
    );
  }

  /// [showSnackBar] method
  void showGrockSnackBarWithIcon(
    String message, {
    Duration? duration,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// [showMaterialBanner] method
  void showGrockMaterialBanner(
    String message, {
    Duration? duration,
    required String actionLabel,
    required VoidCallback action,
  }) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: [
          TextButton(
            child: Text(actionLabel),
            onPressed: action,
          ),
        ],
      ),
    );
  }

  /// [showMaterialBanner] method
  void showGrockMaterialBannerWithIcon(
    String message, {
    Duration? duration,
    required String actionLabel,
    required VoidCallback action,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            child: Text(actionLabel),
            onPressed: action,
          ),
        ],
      ),
    );
  }

  /// [showMaterialBanner] method
  void showGrockMaterialBannerWithIconAndColor(
    String message, {
    Duration? duration,
    required String actionLabel,
    required VoidCallback action,
    required IconData icon,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            child: Text(actionLabel),
            onPressed: action,
          ),
        ],
      ),
    );
  }

  /// [showAdaptiveDialog] method
  Future<void> showGrockAdaptiveDialog({
    required String title,
    required String content,
    required String actionLabel,
    required VoidCallback action,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(actionLabel),
              onPressed: action,
            ),
          ],
        ),
      );
    } else {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(actionLabel),
              onPressed: action,
            ),
          ],
        ),
      );
    }
  }

  /// [showAdaptiveDialog] method
  Future<void> showGrockAdaptiveDialogWithIcon({
    required String title,
    required String content,
    required String actionLabel,
    required VoidCallback action,
    required IconData icon,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(actionLabel),
              onPressed: action,
            ),
          ],
        ),
      );
    } else {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(actionLabel),
              onPressed: action,
            ),
          ],
        ),
      );
    }
  }

  /// [showAdaptiveDatePicker] method
  Future<DateTime?> showGrockAdaptiveDatePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    } else {
      Future<DateTime?> result = Future.value(null);
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.32,
          color: Colors.white,
          child: CupertinoDatePicker(
            initialDateTime: initialDate,
            use24hFormat: true,
            mode: CupertinoDatePickerMode.date,
            minimumDate: firstDate,
            maximumDate: lastDate,
            onDateTimeChanged: (value) {
              setState(() {
                result = Future.value(value);
              });
            },
          ),
        ),
      );
      return result;
    }
  }

  /// [showAdaptiveTimePicker] method
  Future<TimeOfDay?> showGrockAdaptiveTimePicker({
    required TimeOfDay initialTime,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showTimePicker(
        context: context,
        initialTime: initialTime,
      );
    } else {
      Future<TimeOfDay?> result = Future.value(null);
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 200,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              initialTime.hour,
              initialTime.minute,
            ),
            onDateTimeChanged: (value) {
              setState(() {
                result = Future.value(
                  TimeOfDay(
                    hour: value.hour,
                    minute: value.minute,
                  ),
                );
              });
            },
          ),
        ),
      );
      return result;
    }
  }

  /// [showAdaptiveBottomSheet] method
  Future<void> showGrockAdaptiveBottomSheet({
    required Widget child,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showModalBottomSheet(
        context: context,
        builder: (context) => child,
      );
    } else {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => child,
      );
    }
  }

  /// [showAdaptiveBottomSheet] method
  Future<void> showGrockAdaptiveBottomSheetWithIcon({
    required Widget child,
    required IconData icon,
  }) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showModalBottomSheet(
        context: context,
        builder: (context) => child,
      );
    } else {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text('Title'),
            ],
          ),
          message: Text('Message'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Action 1'),
              onPressed: () {},
            ),
            CupertinoActionSheetAction(
              child: Text('Action 2'),
              onPressed: () {},
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel'),
            onPressed: () {},
          ),
        ),
      );
    }
  }

  /// [AdaptiveScaffold] method
  Widget GrockAdaptiveScaffold({
    required Widget body,
    required Widget? floatingActionButton,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return Scaffold(
        body: body,
        floatingActionButton: floatingActionButton,
      );
    } else {
      return CupertinoPageScaffold(
        child: body,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Title'),
        ),
      );
    }
  }

  /// [AdaptiveButton] method
  Widget GrockAdaptiveButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return ElevatedButton(
        child: Text(label),
        onPressed: onPressed,
      );
    } else {
      return CupertinoButton(
        child: Text(label),
        onPressed: onPressed,
      );
    }
  }

  /// [AdaptiveButton] method
  Widget GrockAdaptiveButtonWithIcon({
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      );
    } else {
      return CupertinoButton.filled(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(label),
          ],
        ),
        onPressed: onPressed,
      );
    }
  }

  /// [AdaptiveButton] method
  Widget GrockAdaptiveButtonWithIconAndColor({
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
      );
    } else {
      return CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: color,
        ),
        child: CupertinoButton.filled(
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(label),
            ],
          ),
          onPressed: onPressed,
        ),
      );
    }
  }

  /// [AndroidScrollGlowDisable] method
  Widget AndroidScrollGlowDisable({
    required Widget child,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return ScrollConfiguration(
        behavior: _ScrollGlowConfiguration(),
        child: child,
      );
    } else {
      return child;
    }
  }

  /// [Animation] method
  Widget GrockAnimation({
    required Widget child,
    required AnimationController controller,
    required Animation<double> animation,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    } else {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  }

  /// [Animation] method
  Widget GrockAnimationWithCurve({
    required Widget child,
    required AnimationController controller,
    required Animation<double> animation,
    required Curve curve,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    } else {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  }

  /// [bool value toggle] method
  void toggle(bool value) {
    setState(() {
      value = !value;
    });
  }

  /// [email validation] method
  bool emailValidation(String email) {
    final RegExp regex = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    );
    return regex.hasMatch(email);
  }

  /// [password validation] method
  bool passwordValidation(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  /// [password validation] method
  bool passwordValidationWithSpecialCharacters(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  /// [phone validation] method
  bool phoneValidation(String phone) {
    final RegExp regex = RegExp(
      r'^[0-9]{10}$',
    );
    return regex.hasMatch(phone);
  }

  /// [phone validation] method
  bool phoneValidationWithCountryCode(String phone) {
    final RegExp regex = RegExp(
      r'^[0-9]{12}$',
    );
    return regex.hasMatch(phone);
  }

  /// [phone validation] method
  bool phoneValidationWithCountryCodeAndPlus(String phone) {
    final RegExp regex = RegExp(
      r'^\+[0-9]{12}$',
    );
    return regex.hasMatch(phone);
  }

  /// [Keyboard hidden] method
  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// [is keyboard open] method
  bool isKeyboardOpen() {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// [is keyboard open] method
  bool isKeyboardClosed() {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  /// [safe area bottm] method
  double safeAreaBottom() {
    return MediaQuery.of(context).padding.bottom;
  }

  /// [safe area top] method
  double safeAreaTop() {
    return MediaQuery.of(context).padding.top;
  }

  /// [safe area left] method
  double safeAreaLeft() {
    return MediaQuery.of(context).padding.left;
  }

  /// [safe area right] method
  double safeAreaRight() {
    return MediaQuery.of(context).padding.right;
  }

  /// [safe area] method
  EdgeInsets safeArea() {
    return MediaQuery.of(context).padding;
  }

  /// [safe area] method
  EdgeInsets safeAreaWithPadding() {
    return MediaQuery.of(context).padding + EdgeInsets.all(10);
  }

  /// [safe area] method
  EdgeInsets safeAreaWithPaddingAndBottom(double bottom) {
    return MediaQuery.of(context).padding + EdgeInsets.only(bottom: bottom);
  }

  /// [safe area] method
  EdgeInsets safeAreaWithPaddingAndTop(double top) {
    return MediaQuery.of(context).padding + EdgeInsets.only(top: top);
  }

  /// [safe area] method
  EdgeInsets safeAreaWithPaddingAndLeft(double left) {
    return MediaQuery.of(context).padding + EdgeInsets.only(left: left);
  }

  /// [Hero animation] method
  Widget heroAnimation({
    required Widget child,
    required String tag,
  }) {
    return Hero(
      tag: tag,
      child: child,
    );
  }

  /// [Hero animation] method
  Widget heroAnimationWithTransition({
    required Widget child,
    required String tag,
  }) {
    return Hero(
      tag: tag,
      transitionOnUserGestures: true,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return DefaultTextStyle(
          style: DefaultTextStyle.of(toHeroContext).style,
          child: toHeroContext.widget,
        );
      },
      child: child,
    );
  }

  /// Dynamic height
  double dH(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  /// Dynamic width
  double dW(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  /// Dynbamic text scale factor
  double dTSF(double textScaleFactor) {
    return MediaQuery.of(context).textScaleFactor * textScaleFactor;
  }  

  /// Grock Widget Size
  Widget GetWidgetSize({
    required Widget child,
    required Function(Size size) onSizeChange,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onSizeChange(constraints.biggest);
        });
        return child;
      },
    );
  }

  /// Widget Size and Position
  Widget GetWidgetSizeAndPosition({
    required Widget child,
    required Function(Size size, Offset offset) onSizeChange,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset offset = renderBox.localToGlobal(Offset.zero);
          onSizeChange(constraints.biggest, offset);
        });
        return child;
      },
    );
  }
  
}

class _ScrollGlowConfiguration extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
