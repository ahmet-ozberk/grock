import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

enum GrockPopupMenuStatus { init, dispose, widgetsBinding }

class GrockPopupMenuStyle {
  final Color? splashColor;
  final Color? highlightColor;
  final Color barrierColor;
  final bool barrierDismissible;
  final bool useSafeArea;
  final double width;
  final double blur;
  final Widget Function(BuildContext, int) separatorBuilder;
  final EdgeInsetsGeometry? listViewPadding;
  final bool listViewScaleAnimation;
  final Duration listViewScaleDuration;
  final Alignment listViewScaleAlignment;
  final Curve listViewScaleCurve;
  final PopupMenuEffectType effectType;
  final Duration effectDuration;
  final Alignment effectAlignment;
  final Curve effectCurve;
  final ScrollPhysics? listViewPhysics;
  final Function(
          GrockPopupMenuStatus status, ScrollController scrollController)?
      addListener;
  GrockPopupMenuStyle({
    this.splashColor,
    this.highlightColor,
    this.barrierColor = Colors.black12,
    this.barrierDismissible = true,
    this.useSafeArea = false,
    this.width = .56,
    this.blur = 0.8,
    this.separatorBuilder = _separatorBuilder,
    this.listViewPadding,
    this.listViewScaleAnimation = false,
    this.listViewScaleDuration = const Duration(milliseconds: 200),
    this.listViewScaleAlignment = Alignment.centerRight,
    this.listViewScaleCurve = Curves.decelerate,
    this.effectType = PopupMenuEffectType.scaleIn,
    this.effectDuration = const Duration(milliseconds: 150),
    this.effectAlignment = Alignment.center,
    this.effectCurve = Curves.fastOutSlowIn,
    this.listViewPhysics = const BouncingScrollPhysics(),
    this.addListener,
  })  : assert(0 <= width && width <= 1, "width must be between 0 and 1"),
        assert(-1 < blur, "blur must be greater than 0");

  static Widget _separatorBuilder(BuildContext context, int index) =>
      const SizedBox(height: 2);
}

class GrockPopupMenu extends StatefulWidget {
  final Widget child;
  final GrockPopupMenuStyle? style;
  final List<GrockPopupMenuItem> children;
  const GrockPopupMenu({
    super.key,
    required this.child,
    this.style,
    required this.children,
  });

  @override
  State<GrockPopupMenu> createState() => _GrockPopupMenuState();
}

class _GrockPopupMenuState extends State<GrockPopupMenu> {
  Size? size;
  Offset? offset;
  @override
  Widget build(BuildContext context) {
    final menuStyle = widget.style ?? GrockPopupMenuStyle();
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: InkWell(
        splashColor: menuStyle.splashColor,
        highlightColor: menuStyle.highlightColor,
        onTap: () => showDialog(
          context: context,
          barrierColor: menuStyle.barrierColor,
          barrierDismissible: menuStyle.barrierDismissible,
          useSafeArea: menuStyle.useSafeArea,
          builder: (context) => _GrockPopupMenuDialog(
            position: (offset!, size!),
            style: menuStyle,
            children: widget.children,
          ),
        ),
        child: GrockWidgetSize(
          callback: (s, o) {
            setState(() {
              size = s;
              offset = o;
            });
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _GrockPopupMenuDialog extends StatefulWidget {
  final (Offset, Size) position;
  final GrockPopupMenuStyle style;
  final List<GrockPopupMenuItem> children;
  const _GrockPopupMenuDialog({
    required this.position,
    required this.style,
    required this.children,
  });

  @override
  State<_GrockPopupMenuDialog> createState() => _GrockPopupMenuDialogState();
}

class _GrockPopupMenuDialogState extends State<_GrockPopupMenuDialog> {
  ScrollController scrollController = ScrollController();
  double left(double width, double x, double screenWidth) {
    final double left = x + width;
    if (left > screenWidth) {
      return screenWidth - width;
    }
    return x;
  }

  double topPadding(Offset position, Size size, double screenHeight) {
    final double top = position.dy + size.height;
    if (top > screenHeight - 40) {
      return screenHeight - size.height - 40;
    } else {
      return position.dy + size.height;
    }
  }

  bool _isScale = false;

  void init() {
    widget.style.addListener?.call(GrockPopupMenuStatus.init, scrollController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.style.addListener
          ?.call(GrockPopupMenuStatus.widgetsBinding, scrollController);
      _isScale = widget.style.listViewScaleAnimation;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    widget.style.addListener
        ?.call(GrockPopupMenuStatus.dispose, scrollController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;

    return Material(
      type: MaterialType.transparency,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: widget.style.blur, sigmaY: widget.style.blur),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: left(
                size.width * widget.style.width,
                widget.position.$1.dx,
                size.width,
              ),
              height: size.height,
              width: size.width * widget.style.width,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: () {
                  if (widget.style.listViewScaleAnimation) {
                    return AnimatedScale(
                      scale: _isScale ? 1 : 0,
                      duration: widget.style.listViewScaleDuration,
                      alignment: widget.style.listViewScaleAlignment,
                      curve: widget.style.listViewScaleCurve,
                      child: _listViewWidget(size, safeArea, scrollController),
                    );
                  } else {
                    return _listViewWidget(size, safeArea, scrollController);
                  }
                }(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _listViewWidget(
      Size size, EdgeInsets safeArea, ScrollController scrollController) {
    return ListView.separated(
      controller: scrollController,
      itemCount: widget.children.length,
      shrinkWrap: true,
      physics: widget.style.listViewPhysics,
      padding: widget.style.listViewPadding ??
          EdgeInsets.only(
            top:
                topPadding(widget.position.$1, widget.position.$2, size.height),
            bottom: safeArea.bottom + 12,
            left: 12,
            right: 12,
          ),
      separatorBuilder: widget.style.separatorBuilder,
      itemBuilder: (context, index) => _GrockPopupMenuItem(
        style: widget.style,
        item: widget.children[index],
        index: index,
      ),
    );
  }
}

class _GrockPopupMenuItem extends StatefulWidget {
  final GrockPopupMenuStyle style;
  final GrockPopupMenuItem item;
  final int index;
  const _GrockPopupMenuItem(
      {required this.style, required this.item, required this.index});

  @override
  State<_GrockPopupMenuItem> createState() => __GrockPopupMenuItemState();
}

class __GrockPopupMenuItemState extends State<_GrockPopupMenuItem> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    final double scale = _isHover ? widget.style.effectType.scale : 1;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final item = widget.item;
    return AnimatedScale(
      scale: scale,
      duration: widget.style.effectDuration,
      alignment: widget.style.effectAlignment,
      curve: widget.style.effectCurve,
      onEnd: () => setState(() => _isHover = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHover = true),
        onTap: () => item.onTap?.call(widget.index),
        child: Container(
          height: item.height,
          padding: item.padding,
          margin: item.margin,
          decoration: _decoration(isDarkTheme),
          child: item.child ??
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: item.titleTextStyle ??
                                Theme.of(context).listTileTheme.titleTextStyle,
                          ),
                          if (item.subtitle != null) ...{
                            Text(
                              item.subtitle!,
                              style: item.subtitleTextStyle ??
                                  Theme.of(context).textTheme.bodySmall,
                            ),
                          }
                        ],
                      ),
                    ),
                    if (item.trailing != null) ...{
                      const SizedBox(width: 4),
                      item.trailing!,
                    }
                  ],
                ),
              ),
        ),
      ),
    );
  }

  BoxDecoration _decoration(bool isDarkTheme) {
    return BoxDecoration(
      color: isDarkTheme
          ? CupertinoColors.darkBackgroundGray
          : CupertinoColors.extraLightBackgroundGray,
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(
          color: isDarkTheme
              ? Colors.white.withOpacity(.02)
              : Colors.black.withOpacity(.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

class GrockPopupMenuItem {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final double height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function(int index)? onTap;
  GrockPopupMenuItem({
    required this.title,
    this.child,
    this.subtitle,
    this.trailing,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.margin = EdgeInsets.zero,
    this.onTap,
  });
}

enum PopupMenuEffectType {
  scaleIn(0.98),
  mediumScaleIn(0.94),
  bigScaleIn(0.90),
  scaleOut(1.02),
  mediumScaleOut(1.04),
  bigScaleOut(1.08),
  none(1);

  final double scale;
  const PopupMenuEffectType(this.scale);
}
