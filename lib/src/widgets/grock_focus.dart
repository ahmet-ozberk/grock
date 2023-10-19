// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

enum GrockFocusChildType {
  menu,
  widget,
}

enum GrockFocusTappedType {
  tap,
  longPress,
}

enum GrockFocusAnimationType {
  scale,
  fade,
  slide,
  none,
}

class GrockFocusController {
  late _GrockFocusState _widgetState;
  bool _isOpened = false;

  void _addState(_GrockFocusState widgetState) {
    _widgetState = widgetState;
  }

  void open() {
    _widgetState.open(_widgetState.context);
    _widgetState.widget.addListenerState?.call(true);
    _isOpened = true;
  }

  void close() {
    if (_isOpened) {
      _widgetState.widget.addListenerState?.call(false);
      Navigator.pop(_widgetState.context);
      _isOpened = false;
    }
  }
}

class GrockFocusedStyle {
  /// blurSize default value is 3
  final double blurSize;

  /// blurBackgroundColor default value is Colors.black
  final Color blurBackgroundColor;

  /// blurBackgroundColorOpacity default value is 0.7
  final double blurBackgroundColorOpacity;

  /// animationType Duration value default value is 200 milliseconds
  final Duration openedDuration;

  /// animationType is GrockFocusAnimationType.scale, alignment is Alignment
  final AlignmentGeometry scaleAlignment;

  /// Widget border radius value default value is 0
  final double borderRadius;

  /// Focused vertical drag is enbale
  final bool verticalDrag;

  /// Focused background widget
  Widget dragBackgroundWidget;
  GrockFocusedStyle({
    this.blurSize = 3,
    this.blurBackgroundColor = Colors.black,
    this.blurBackgroundColorOpacity = 0.7,
    this.openedDuration = const Duration(milliseconds: 200),
    this.scaleAlignment = Alignment.center,
    this.borderRadius = 0,
    this.verticalDrag = false,
    this.dragBackgroundWidget = const SizedBox(),
  });
}

class GrockFocusedMenuStyle {
  final double menuItemExtent;
  final double? menuItemWidth;
  final double? leftSpace;

  final double? rightSpace;
  final bool isMenuItemAnimation;
  final bool isScaleAnimation;
  final int menuItemAnimationDurationExtent;
  final double menuSeperatedHeight;
  final Color menuSeperatedColor;
  final BorderRadiusGeometry? menuBorderRadius;
  final Color? menuBackgroundColor;
  GrockFocusedMenuStyle({
    this.menuItemExtent = 56,
    this.menuItemWidth,

    /// Default value vhild width
    this.leftSpace,

    /// Default value MediaQuery.of(context).size.width * 0.4
    this.rightSpace,
    this.isMenuItemAnimation = true,
    this.isScaleAnimation = false,
    this.menuItemAnimationDurationExtent = 100,
    this.menuSeperatedHeight = 0,
    this.menuSeperatedColor = Colors.grey,
    this.menuBorderRadius,
    this.menuBackgroundColor,
  });
}

class GrockFocusMenuItem {
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? child;
  final Function? onPressed;
  GrockFocusMenuItem({
    required this.text,
    this.trailing,
    this.leading,
    this.backgroundColor,
    this.textStyle,
    this.child,
    this.onPressed,
  });
}

class GrockFocus extends StatefulWidget {
  const GrockFocus({
    super.key,
    this.controller,
    required this.child,
    this.tappedType = GrockFocusTappedType.tap,
    this.onPressed,
    this.addListenerState,
    this.duration,
    this.animationType = GrockFocusAnimationType.fade,
    this.style,
    this.childType = GrockFocusChildType.menu,
    this.menuItems,
    this.focusWidget,
    this.menuStyle,
  }) : assert(
            (childType == GrockFocusChildType.menu && menuItems != null) ||
                (childType == GrockFocusChildType.widget && focusWidget != null),
            'childType is GrockFocusChildType.menu, menuItems is required\nchildType is GrockFocusChildType.widget, widget is required');

  /// GrockFocusController to control the GrockFocus
  final GrockFocusController? controller;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Open with tap insted of long press. Default value is GrockFocusTappedType.tap
  final GrockFocusTappedType tappedType;

  /// OnPressed callback
  final Function? onPressed;

  /// AddListenerState GrockFocus state
  final Function(bool? isOpen)? addListenerState;

  /// Opened-Closed Duration
  final Duration? duration;

  /// GrockFocusAnimationType to control the GrockFocus. Default value is GrockFocusAnimationType.fade
  final GrockFocusAnimationType animationType;

  /// GrockFocusStyle to control the GrockFocus. Default value is GrockFocusStyle()
  final GrockFocusedStyle? style;

  /// The GrockFocusChildType parameter determines what opens when focused. Default value is GrockFocusChildType.menu
  final GrockFocusChildType childType;

  /// childType is GrockFocusChildType.menu, menuItems is required
  final List<GrockFocusMenuItem>? menuItems;

  /// childType is GrockFocusChildType.widget, widget is required
  final Widget? focusWidget;

  /// GrockFocusedMenuStyle to control the GrockFocus. Default value is GrockFocusedMenuStyle()
  final GrockFocusedMenuStyle? menuStyle;

  @override
  State<GrockFocus> createState() => _GrockFocusState();
}

class _GrockFocusState extends State<GrockFocus> {
  final gestureKey = GlobalKey();
  Offset childOffset = const Offset(0, 0);
  Size? childSize;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!._addState(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: gestureKey,
      onTap: () async {
        if (widget.tappedType == GrockFocusTappedType.tap) {
          widget.onPressed?.call();
          await open(context);
        }
      },
      onLongPress: () async {
        if (widget.tappedType == GrockFocusTappedType.longPress) {
          widget.onPressed?.call();
          await open(context);
        }
      },
      child: widget.child,
    );
  }

  void _getOffset() {
    final RenderBox renderBox = gestureKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    setState(() {
      childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  Future<void> open(BuildContext context) async {
    _getOffset();
    widget.addListenerState?.call(true);

    await Navigator.push(
      context,
      PageRouteBuilder(
          fullscreenDialog: true,
          opaque: false,
          transitionDuration: widget.duration ?? const Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: _GrockFocusDetail(
                childOffset: childOffset,
                childSize: childSize!,
                style: widget.style ?? GrockFocusedStyle(),
                animationType: widget.animationType,
                childType: widget.childType,
                menuItems: widget.menuItems,
                focusWidget: widget.focusWidget,
                menuStyle: widget.menuStyle,
                child: widget.child,
              ),
            );
          }),
    ).whenComplete(() => widget.addListenerState?.call(false));
  }
}

class _GrockFocusDetail extends StatefulWidget {
  final Widget child;
  Offset childOffset;
  final Size childSize;
  final GrockFocusedStyle style;
  final GrockFocusAnimationType animationType;
  final GrockFocusChildType childType;
  final List<GrockFocusMenuItem>? menuItems;
  final Widget? focusWidget;
  final GrockFocusedMenuStyle? menuStyle;
  _GrockFocusDetail({
    required this.child,
    required this.childOffset,
    required this.childSize,
    required this.style,
    required this.animationType,
    required this.childType,
    this.menuItems,
    this.focusWidget,
    this.menuStyle,
  });

  @override
  State<_GrockFocusDetail> createState() => __GrockFocusDetailState();
}

class __GrockFocusDetailState extends State<_GrockFocusDetail> {
  late final double topSpace;
  late final double leftSpace;
  double scale = 1;

  @override
  void initState() {
    super.initState();
    topSpace = widget.childOffset.dy;
    leftSpace = widget.childOffset.dx;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final menuStyle = widget.menuStyle ?? GrockFocusedMenuStyle();
    final size = MediaQuery.of(context).size;
    final topSafeArea = MediaQuery.of(context).padding.top;
    final topOffset =
        widget.childOffset.dy.abs() + (widget.childOffset.dy < topSafeArea ? topSafeArea : 0);
    final leftOffset = widget.childOffset.dx;
    final menuHeight = ((widget.menuItems?.length ?? 0) * (menuStyle.menuItemExtent) +
        (widget.menuItems?.length ?? 0) * menuStyle.menuSeperatedHeight);
    final menuPositionIsTop = topOffset > size.height / 2;
    final menuTopOffset = topOffset - menuHeight;
    final menuBottomOffset = size.height - topOffset - widget.childSize.height - menuHeight;

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          onVerticalDragUpdate: !style.verticalDrag
              ? null
              : (details) {
                  setState(() {
                    widget.childOffset = Offset(leftOffset, topOffset + details.delta.dy);
                    scale = widget.childOffset.dy == topSpace
                        ? 1
                        : 1 - (widget.childOffset.dy.abs() / size.height);
                  });
                },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: style.blurSize, sigmaY: style.blurSize),
            child: Container(
              color: style.blurBackgroundColor.withOpacity(
                style.blurBackgroundColorOpacity,
              ),
            ),
          ),
        ),
        if (style.verticalDrag) ...{
          Positioned(
            top: topSpace,
            left: leftSpace,
            child: SizedBox(
              width: widget.childSize.width,
              height: widget.childSize.height,
              child: style.dragBackgroundWidget,
            ),
          ),
        },
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: topOffset,
          left: leftOffset,
          child: SizedBox(
            width: widget.childSize.width,
            height: widget.childSize.height,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: style.openedDuration,
              builder: (context, double value, child) {
                switch (widget.animationType) {
                  case GrockFocusAnimationType.fade:
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  case GrockFocusAnimationType.scale:
                    return Transform.scale(
                      scale: value,
                      alignment: widget.style.scaleAlignment,
                      child: child,
                    );
                  case GrockFocusAnimationType.slide:
                    return Transform.translate(
                      offset: Offset(0, size.height * (1 - value)),
                      child: child,
                    );
                  case GrockFocusAnimationType.none:
                    return child!;
                }
              },
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 200),
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: style.borderRadius),
                  duration: style.openedDuration,
                  builder: (context, double value, child) => ClipRRect(
                    borderRadius: BorderRadius.circular(value),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: menuPositionIsTop ? menuTopOffset : null,
          bottom: menuPositionIsTop ? null : menuBottomOffset,
          left: menuStyle.leftSpace ?? leftOffset,
          right: menuStyle.rightSpace,
          child: GrockScaleAnimation(
            alignment: menuPositionIsTop ? Alignment.bottomCenter : Alignment.topCenter,
            begin: menuStyle.isScaleAnimation ? 0.0 : 1.0,
            duration: menuStyle.isScaleAnimation
                ? Duration.zero
                : Duration(milliseconds: menuStyle.menuItemAnimationDurationExtent * 6),
            child: Container(
              height: menuHeight,
              width: menuStyle.rightSpace == null
                  ? menuStyle.menuItemWidth ?? widget.childSize.width
                  : double.infinity,
              decoration: BoxDecoration(
                color: menuStyle.menuBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                borderRadius: menuStyle.menuBorderRadius ?? BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: menuStyle.menuBorderRadius ?? BorderRadius.circular(4),
                child: ListView.separated(
                  itemCount: widget.menuItems?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => _seperatedWidget(
                    menuStyle,
                    menuPositionIsTop,
                    index,
                  ),
                  itemBuilder: (context, index) {
                    final item = widget.menuItems![index];
                    if (menuStyle.isMenuItemAnimation) {
                      return SizedBox(
                        height: menuStyle.menuItemExtent,
                        child: GrockFadeAnimation(
                          value: 500,
                          alignment: _fadeAlignment(menuPositionIsTop),
                          duration: Duration(
                            milliseconds: 100 + (index * menuStyle.menuItemAnimationDurationExtent),
                          ),
                          child: _menuItem(item),
                        ),
                      );
                    }
                    return SizedBox(
                      height: menuStyle.menuItemExtent,
                      child: _menuItem(item),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuItem(GrockFocusMenuItem item) {
    return item.child ??
        ListTile(
          leading: item.leading,
          title: Text(
            item.text,
            style: item.textStyle,
          ),
          onTap: () {
            item.onPressed?.call();
            Navigator.pop(context);
          },
          trailing: item.trailing,
          focusColor: item.backgroundColor,
        ).material;
  }

  Alignment _fadeAlignment(bool menuPositionIsTop) {
    return menuPositionIsTop ? Alignment.bottomCenter : Alignment.topCenter;
  }

  GrockFadeAnimation _seperatedWidget(
      GrockFocusedMenuStyle menuStyle, bool menuPositionIsTop, int index) {
    return GrockFadeAnimation(
      value: 500,
      alignment: menuStyle.isMenuItemAnimation
          ? menuPositionIsTop
              ? Alignment.bottomCenter
              : Alignment.topCenter
          : Alignment.center,
      duration: Duration(milliseconds: 200 + (index * menuStyle.menuItemAnimationDurationExtent)),
      child: Divider(
          height: menuStyle.menuSeperatedHeight,
          color: menuStyle.menuSeperatedColor,
          thickness: menuStyle.menuSeperatedHeight),
    );
  }
}
