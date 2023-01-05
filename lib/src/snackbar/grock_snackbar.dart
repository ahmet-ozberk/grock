import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../grock.dart';

class GrockSnackbar {
  static OverlayEntry? overlayEntry;
  static bool isShowing = false;
  static Future<void> showSnackbar({
    required String title,
    required String description,
    BorderRadiusGeometry? borderRadius,
    Widget? body,
    required Duration duration,
    required SnackbarPosition position,
    required Curve curve,
    double? blur,
    required Duration openDuration,
    double? opacity,
    Color? color,
    double? width,
    EdgeInsetsGeometry? padding,
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
  }) async {
    OverlayState overlayState = Grock.navigationKey.currentState!.overlay!;
    overlayEntry = OverlayEntry(builder: (context) {
      isShowing = true;
      return Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(Grock.navigationKey.currentState!.overlay!.context).size.width,
              child: _SnackbarBody(
                overlayEntry: overlayEntry!,
                borderRadius: borderRadius,
                duration: duration,
                position: position,
                body: body,
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
              ),
            ),
          ],
        ),
      );
    });
    overlayState.insert(overlayEntry!);
  }

  static void dialog({
    required Widget Function(BuildContext grockContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    showDialog(
      context: Grock.navigationKey.currentContext!,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
}

// ignore: must_be_immutable
class _SnackbarBody extends StatefulWidget {
  OverlayEntry overlayEntry;
  BorderRadiusGeometry? borderRadius;
  Duration duration;
  SnackbarPosition position;
  Curve curve;
  Widget? body;
  double? blur;
  Duration openDuration;
  double? opacity;
  Color? color;
  double? width;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? leadingPadding;
  EdgeInsetsGeometry? trailingPadding;
  EdgeInsetsGeometry? titlePadding;
  EdgeInsetsGeometry? descriptionPadding;
  Widget? leading;
  Widget? trailing;
  double? itemSpaceHeight;
  String title;
  String description;
  Color? titleColor;
  Color? descriptionColor;
  double? titleSize;
  double? descriptionSize;
  TextStyle? titleStyle;
  TextStyle? descriptionStyle;
  BoxBorder? border;
  _SnackbarBody(
      {required this.overlayEntry,
      this.borderRadius,
      this.duration = const Duration(seconds: 4),
      this.curve = Curves.fastOutSlowIn,
      this.openDuration = const Duration(milliseconds: 800),
      this.position = SnackbarPosition.bottom,
      this.blur,
      this.opacity,
      this.body,
      this.color,
      this.width,
      this.border,
      this.itemSpaceHeight,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      this.margin,
      this.leadingPadding,
      this.trailingPadding,
      this.titlePadding,
      this.descriptionPadding,
      this.leading,
      this.trailing,
      required this.title,
      required this.description,
      this.titleColor,
      this.descriptionColor,
      this.titleSize,
      this.descriptionSize,
      this.titleStyle,
      this.descriptionStyle});

  @override
  _SnackbarBodyState createState() => _SnackbarBodyState();
}

class _SnackbarBodyState extends State<_SnackbarBody> with TickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  //late Timer time;
  int i = 0;

  bool _isClosed = true;

  @override
  void initState() {
    super.initState();
    animationStarter();
    _controller!.forward();
    if (_isClosed) {
      _closeSnackbar();
    }
  }

  void animationStarter() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.openDuration,
      reverseDuration: widget.openDuration,
    );
    _animation = Tween<double>(begin: -Grock.width, end: 0)
        .animate(CurvedAnimation(parent: _controller!, curve: Interval(0, 1, curve: widget.curve)))
      ..addListener(() {
        setState(() {});
      });
  }

  void _closeSnackbar() {
    Future.delayed(widget.duration - widget.openDuration, () {
      if (_controller != null && _isClosed) {
        if (GrockSnackbar.overlayEntry != null) {
          _controller?.reverse().then((value) {
            if (!mounted) {
              widget.overlayEntry.remove();
            }
            GrockSnackbar.isShowing = false;
            _controller?.dispose();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.body ?? GestureDetector(
      onVerticalDragEnd: (details) {
        setState(() {
          _isClosed = false;
        });
        _controller?.reverse().then((value) {
          if (!mounted) {
            widget.overlayEntry.remove();
          }
          GrockSnackbar.isShowing = false;
          _controller?.dispose();
        });
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: widget.position.getPosition,
            children: [
              Padding(
                padding: widget.margin ?? widget.position.getPadding(),
                child: _transformWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Transform _transformWidget(BuildContext context) {
    return Transform.translate(
      offset: widget.position.getOffset(value: _animation.value),
      child: _glassMorphism(context),
    );
  }

  _GlassMorphism _glassMorphism(BuildContext context) {
    return _GlassMorphism(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
      blur: widget.blur ?? 15,
      opacity: widget.opacity ?? 0.6,
      color: widget.color ?? Colors.white,
      border: widget.border,
      child: Container(
        padding: widget.padding,
        width: widget.width ?? Grock.width,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.leading != null ? _leadingWidget() : Container(),
            SizedBox(width: widget.leading == null ? 0 : 5),
            _bodyWidgets(context),
            const SizedBox(
              width: 10,
            ),
            widget.trailing != null ? _trailingWidget() : Container(),
          ],
        ),
      ),
    );
  }

  Padding _leadingWidget() {
    return Padding(padding: widget.leadingPadding ?? EdgeInsets.zero, child: widget.leading);
  }

  Expanded _bodyWidgets(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleWidget(context),
          SizedBox(height: widget.itemSpaceHeight ?? 2),
          _descriptionWidget(context),
        ],
      ),
    );
  }

  Padding _trailingWidget() {
    return Padding(padding: widget.trailingPadding ?? EdgeInsets.zero, child: widget.trailing);
  }

  Padding _descriptionWidget(BuildContext context) {
    return Padding(
      padding: widget.descriptionPadding ?? EdgeInsets.zero,
      child: Text(
        widget.description,
        style: widget.descriptionStyle ?? Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Padding _titleWidget(BuildContext context) {
    return Padding(
      padding: widget.titlePadding ?? EdgeInsets.zero,
      child: Text(
        widget.title,
        style: widget.titleStyle ??
            Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
      ),
    );
  }
}

enum SnackbarPosition {
  top(MainAxisAlignment.start),
  bottom(MainAxisAlignment.end);

  final MainAxisAlignment position;
  const SnackbarPosition(this.position);

  MainAxisAlignment get getPosition => position;

  EdgeInsetsGeometry getPadding() {
    if (position == MainAxisAlignment.start) {
      return const EdgeInsets.only(top: 20, left: 20, right: 20);
    } else {
      return const EdgeInsets.only(bottom: 20, left: 20, right: 20);
    }
  }

  Offset getOffset({required double value}) {
    if (position == MainAxisAlignment.start) {
      return Offset(0, value);
    } else {
      return Offset(0, -value);
    }
  }
}

// ignore: must_be_immutable
class _GlassMorphism extends StatelessWidget {
  double blur;
  double opacity;
  Widget child;
  Color color;
  BorderRadiusGeometry borderRadius;
  BoxBorder? border;
  _GlassMorphism(
      {Key? key,
      required this.blur,
      required this.opacity,
      required this.child,
      required this.color,
      required this.borderRadius,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(color: color.withOpacity(opacity), borderRadius: borderRadius, border: border),
          child: child,
        ),
      ),
    );
  }
}
