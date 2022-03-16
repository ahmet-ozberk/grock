import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/src/model/scaffoldMessenger.dart';
import 'package:provider/provider.dart';

import '../../grock.dart';

class GrockSnackbar {
  static void showSnackbar(
      {double? borderRadius,
      int? durationMillisecond,
      Curve? curve,
      EdgeInsets? margin,
      double? blur,
      double? opacity,
      Color? bgColor,
      double? width,
      Color? progressColor,
      Color? progressBgColor,
      double? padding,
      IconData? icon,
      Color? iconColor,
      double? iconSize,
      required String title,
      required String description,
      Color? titleColor,
      Color? descriptionColor,
      double? titleSize,
      double? descriptionSize,
      TextStyle? titleStyle,
      TextStyle? descriptionStyle}) {
    ScaffoldMessengerModel.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: margin ?? EdgeInsets.symmetric(vertical: 15),
        padding: 10.horizontalP,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        duration: Duration(milliseconds: durationMillisecond ?? 2500),
        content: ChangeNotifierProvider(
          create: (context) => GrockSnackbarProvider(),
          builder: (context, child) => _SnackbarBody(
            onStart: (controller) => Provider.of<GrockSnackbarProvider>(context)
                .startAnimate(controller),
            borderRadius: borderRadius,
            durationMillisecond: durationMillisecond ?? 2500,
            curve: curve ?? Curves.elasticInOut,
            blur: blur,
            opacity: opacity,
            bgColor: bgColor,
            width: width,
            // progressColor: progressColor,
            // progressBgColor: progressBgColor,
            padding: padding,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
            title: title,
            titleColor: titleColor,
            description: description,
            descriptionColor: descriptionColor,
            titleSize: titleSize,
            descriptionSize: descriptionSize,
            titleStyle: titleStyle,
            descriptionStyle: descriptionStyle,
          ),
        ),
      ),
    );
  }

  static void dialog({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    showDialog(
      context: Grock.navigationKey.currentContext,
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

class _SnackbarBody extends StatefulWidget {
  Function(AnimationController controller) onStart;
  //GestureTapCallback? onTap;
  double? borderRadius;
  int durationMillisecond;
  Curve curve;
  double? blur;
  double? opacity;
  Color? bgColor;
  double? width;
  // Color? progressColor;
  // Color? progressBgColor;
  double? padding;
  IconData? icon;
  Color? iconColor;
  double? iconSize;
  String title;
  String description;
  Color? titleColor;
  Color? descriptionColor;
  double? titleSize;
  double? descriptionSize;
  TextStyle? titleStyle;
  TextStyle? descriptionStyle;
  _SnackbarBody(
      {required this.onStart,
      // required this.onTap,
      this.borderRadius,
      required this.durationMillisecond,
      required this.curve,
      this.blur,
      this.opacity,
      this.bgColor,
      this.width,
      // this.progressColor,
      // this.progressBgColor,
      this.padding,
      this.icon,
      this.iconColor,
      this.iconSize,
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

class _SnackbarBodyState extends State<_SnackbarBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer time;
  int i = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GrockSnackbarProvider>(context, listen: false);
    time = Timer.periodic(const Duration(milliseconds: 2), (timer) {
      i += 2;
      if (i > widget.durationMillisecond - 400) {
        timer.cancel();
        time.cancel();
        _controller.reverse();
      }
    });
    animationStarter();
    widget.onStart(_controller);
  }

  void animationStarter() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: -Grock.width, end: 0).animate(
        CurvedAnimation(
            parent: _controller, curve: Interval(0, 1, curve: widget.curve)))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GrockSnackbarProvider(),
      child: Transform.translate(
        offset: Offset(_animation.value, 0),
        child: _GlassMorphism(
          borderRadius: widget.borderRadius ?? 20,
          blur: widget.blur ?? 50,
          opacity: widget.opacity ?? 0.1,
          color: widget.bgColor ?? Colors.transparent,
          child: GrockContainer(
            onTap: () {
              ScaffoldMessengerModel.scaffoldMessengerKey.currentState
                  ?.clearSnackBars();
              //widget.onTap?.call();
            },
            width: widget.width ?? Grock.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            ),
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(widget.padding ?? 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.icon != null
                            ? Icon(
                                widget.icon,
                                size: widget.iconSize ?? 36,
                                color: widget.iconColor ?? Colors.black87,
                              )
                            : Container(),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                style: widget.titleStyle ??
                                    TextStyle(
                                      color: widget.titleColor ?? Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.titleSize ?? 16,
                                    ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.description,
                                style: widget.descriptionStyle ??
                                    TextStyle(
                                      color: widget.descriptionColor ??
                                          Colors.black,
                                      fontSize: widget.descriptionSize ?? 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassMorphism extends StatelessWidget {
  double blur;
  double opacity;
  Widget child;
  Color color;
  double borderRadius;
  Color? borderColor;
  _GlassMorphism(
      {Key? key,
      required this.blur,
      required this.opacity,
      required this.child,
      required this.color,
      required this.borderRadius,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor?.withOpacity(0.3) ?? color.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
