// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, unused_element
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

/// Grock Menu IOS Style Widget
/// A menu tray that can be used to display a menu of items.
/// The menu tray is a container that can be used to display a menu of items.

enum GrockMenuTapType { onTap, onLongPress }

enum GrockMenuAnimationType { scale, slide, fade, fadeScale, fadeSlide, none }

class GrockMenuController {
  late _GrockMenuCoreState _state;
  late _GrockMenuState _menuState;

  void _initState(_GrockMenuCoreState state) {
    _state = state;
  }

  void _initMenuState(_GrockMenuState state) {
    _menuState = state;
  }

  /// The close method is used to close the menu.
  void close() {
    _state.closeMenu();
  }

  /// The open method is used to open the menu.
  void open() {
    _menuState.openMenu();
  }
}

class GrockMenu extends StatefulWidget {
  /// The child is the widget that will be displayed when the menu is closed.
  final Widget child;

  /// The items are the menu items that will be displayed when the menu is open.
  final BorderRadiusGeometry? borderRadius;
  final GrockMenuController? controller;

  /// MediaQuery.of(context).size.height * 0.35
  final int? maxHeight;

  /// MediaQuery.of(context).size.width * 0.55
  final double? minWidth;

  /// Colors.grey.shade100
  final Color? backgroundColor;

  final Color? pressColor;

  /// CupertinoColors.separatorwithOpacity(0.2)
  final Color? dividerColor;

  /// Default GrockMenuTapType.onTap
  final GrockMenuTapType tapType;

  /// Default Automatic
  final double? leftSpace;

  /// Default null
  final double? rightSpace;

  /// Default Automatic
  final double? topSpace;

  /// Default null
  final double? bottomSpace;

  /// Default Tween<double>(begin: 0.0, end: 1.1)
  final Tween<double>? tween;

  /// ScrollPhysics parent physics or null
  final ScrollPhysics? physics;

  /// Default 1.0
  final double? dividerHeight;

  /// List of GrockMenuItem items
  final List<GrockMenuItem> items;

  /// Text maxLines value
  final int? maxLines;

  /// Default TextAlign.start
  final TextAlign? textAlign;

  /// Default TextOverflow.ellipsis
  final TextOverflow? textOverflow;

  /// Default EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
  final EdgeInsetsGeometry? padding;

  /// OnTap callback function with index
  final Function(int value)? onTap;

  /// Default false
  final bool onTapClose;
  final BoxBorder? border;

  /// Background space color of the menu
  final Color spaceColor;
  final Duration openAnimationDuration;
  final Duration closeAnimationDuration;

  /// Default Curves.fastOutSlowIn
  final Curve openAnimation;

  /// Default Duration(milliseconds: 450)
  final Curve closeAnimation;
  final TextStyle? textStyle;
  final Alignment? openAlignment;
  final double backgroundBlur;
  final double spaceBlur;
  final Decoration? backgroundDecoration;
  final Widget Function(BuildContext context, int index)? divider;
  final bool isTopSpace;
  final bool isLeftSpace;
  final GrockMenuAnimationType animationType;
  final Tween<Offset>? slideTween;

  const GrockMenu({
    Key? key,

    /// The child is the widget that will be displayed when the menu is closed.
    required this.child,

    /// The items are the menu items that will be displayed when the menu is open.
    required this.items,

    /// The onTap is the callback that will be called when the menu item is tapped.
    this.onTap,

    /// The controller is the controller that will be used to control the menu.
    this.controller,

    /// The physics is the physics that will be used to control the menu.
    this.physics,

    /// The maxHeight is the maximum height of the menu.
    this.maxHeight,

    /// The minWidth is the minimum width of the menu.
    this.minWidth,

    /// The borderRadius is the border radius of the menu.
    this.borderRadius,

    /// The dividerColor is the color of the divider.
    this.dividerColor,

    /// The dividerHeight is the height of the divider.
    this.dividerHeight = 1.0,

    /// The tapType is the type of tap that will open the menu.
    this.tapType = GrockMenuTapType.onTap,

    /// The textStyle is the text style of the menu item.
    this.textStyle,

    /// The backgroundColor is the background color of the menu.
    this.backgroundColor,

    /// The border is the border of the menu.
    this.border,

    /// The pressColor is the color of the menu item when it is pressed.
    this.pressColor = Colors.white,

    /// The maxLines is the maximum number of lines of the menu item.
    this.maxLines,

    /// The textAlign is the text alignment of the menu item.
    this.textAlign,

    /// The textOverflow is the text overflow of the menu item.
    this.textOverflow = TextOverflow.ellipsis,

    /// The padding is the padding of the menu item.
    this.padding,

    /// The onTapClose is the boolean that will be used to determine whether the menu will close when the menu item is tapped.
    this.onTapClose = true,

    /// The spaceColor is the color of the space between the menu and the menu item.
    this.spaceColor = Colors.black26,

    /// The openAnimationDuration is the duration of the open animation.
    this.openAnimationDuration = const Duration(milliseconds: 300),

    /// The closeAnimationDuration is the duration of the close animation.
    this.closeAnimationDuration = const Duration(milliseconds: 250),

    /// The openAnimation is the open animation.
    this.openAnimation = Curves.fastOutSlowIn,

    /// The closeAnimation is the close animation.
    this.closeAnimation = Curves.linear,

    /// The openAlignment is the alignment of the menu when it is open.
    this.openAlignment,

    /// The backgroundBlur is the blur of the background when the menu is open.
    this.backgroundBlur = 40.0,

    /// The spaceBlur is the blur of the space between the menu and the menu item.
    this.spaceBlur = 1.0,

    /// The leftSpace is the left space between the menu and the menu item.
    this.leftSpace,

    /// The rightSpace is the right space between the menu and the menu item.
    this.rightSpace,

    /// The topSpace is the top space between the menu and the menu item.
    this.topSpace,

    /// The bottomSpace is the bottom space between the menu and the menu item.
    this.bottomSpace,

    /// The startTween is the start tween of the menu item.
    this.tween,

    /// The backgroundDecoration is the decoration of the background when the menu is open.
    this.backgroundDecoration,

    /// The divider is the divider between the menu items.
    this.divider,

    /// The isTopSpace is the boolean that will be used to determine whether the top space will be displayed.
    this.isTopSpace = false,

    /// The isLeftSpace is the boolean that will be used to determine whether the left space will be displayed.
    this.isLeftSpace = false,

    /// GrockMenuAnimationType is the animation type of the menu.
    this.animationType = GrockMenuAnimationType.fadeSlide,

    /// The slideTween is the slide tween of the menu.
    this.slideTween,
  }) : super(key: key);

  @override
  State<GrockMenu> createState() => _GrockMenuState();
}

class _GrockMenuState extends State<GrockMenu> {
  Offset _tapPosition = Offset.zero;
  final key = GlobalKey(debugLabel: "GrockMenu GlobalKey");
  Size? _childSize;
  void getOffset() {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _tapPosition = position;
  }

  @override
  void initState() {
    super.initState();
    widget.controller?._initMenuState(this);
  }

  void openMenu() {
    getOffset();
    OverlayState overlayState = Overlay.of(context);
    late OverlayEntry _menuOverlayEntry;
    _menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return _GrockMenuCore(
          overlayEntry: _menuOverlayEntry,
          offset: _tapPosition,
          physics: widget.physics,
          controller: widget.controller,
          items: widget.items,
          onTap: widget.onTap,
          maxHeight: widget.maxHeight,
          minWidth: widget.minWidth ?? MediaQuery.of(context).size.width * 0.55,
          dividerColor: widget.dividerColor,
          dividerHeight: widget.dividerHeight,
          borderRadius: widget.borderRadius,
          textStyle: widget.textStyle,
          backgroundColor: widget.backgroundColor,
          pressColor: widget.pressColor,
          maxLines: widget.maxLines,
          textAlign: widget.textAlign,
          textOverflow: widget.textOverflow,
          padding: widget.padding,
          onTapClose: widget.onTapClose,
          border: widget.border,
          spaceColor: widget.spaceColor,
          openAnimationDuration: widget.openAnimationDuration,
          closeAnimationDuration: widget.closeAnimationDuration,
          openAnimation: widget.openAnimation,
          closeAnimation: widget.closeAnimation,
          openAlignment: widget.openAlignment,
          childSize: _childSize ?? Size.zero,
          backgroundBlur: widget.backgroundBlur,
          leftSpace: widget.leftSpace,
          rightSpace: widget.rightSpace,
          topSpace: widget.topSpace,
          bottomSpace: widget.bottomSpace,
          tween: widget.tween,
          spaceBlur: widget.spaceBlur,
          backgroundDecoration: widget.backgroundDecoration,
          divider: widget.divider,
          isTopSpace: widget.isTopSpace,
          isLeftSpace: widget.isLeftSpace,
          animationType: widget.animationType,
          slideTween: widget.slideTween ??
              Tween<Offset>(begin: const Offset(0, -0.26), end: Offset.zero),
        );
      },
    );
    overlayState.insert(_menuOverlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      key: key,
      onTap: widget.tapType == GrockMenuTapType.onTap ? () => openMenu() : null,
      onLongPress: widget.tapType == GrockMenuTapType.onLongPress
          ? () => openMenu()
          : null,
      child: GrockWidgetSize(
        callback: (size, offset) => setState(() => _childSize = size),
        child: widget.child,
      ),
    );
  }
}

class _GrockMenuCore extends StatefulWidget {
  Offset offset;
  OverlayEntry overlayEntry;
  GrockMenuController? controller;
  int? maxHeight;
  Widget? title;
  Widget? bottomWidget;
  ScrollPhysics? physics;
  double minWidth;
  BorderRadiusGeometry? borderRadius;
  Color? backgroundColor;
  Color? pressColor;
  List<GrockMenuItem> items;
  int? maxLines;
  TextStyle? textStyle;
  BoxBorder? border;
  Color? dividerColor;
  double? dividerHeight;
  TextAlign? textAlign;
  TextOverflow? textOverflow;
  EdgeInsetsGeometry? padding;
  Function(int value)? onTap;
  bool onTapClose;
  Color spaceColor;
  Duration openAnimationDuration;
  Duration closeAnimationDuration;
  Curve openAnimation;
  Curve closeAnimation;
  Alignment? openAlignment;
  Size childSize;
  final double backgroundBlur;
  final double? leftSpace;
  final double? rightSpace;
  final double? topSpace;
  final double? bottomSpace;
  final Tween<double>? tween;
  final double spaceBlur;
  final Decoration? backgroundDecoration;
  final Widget Function(BuildContext context, int index)? divider;
  final bool isTopSpace;
  final bool isLeftSpace;
  final GrockMenuAnimationType animationType;
  Tween<Offset> slideTween;

  _GrockMenuCore({
    super.key,
    required this.overlayEntry,
    required this.offset,
    required this.items,
    this.controller,
    this.onTap,
    this.physics,
    this.maxHeight,
    required this.minWidth,
    this.borderRadius,
    this.backgroundColor,
    this.dividerColor,
    this.textStyle,
    this.dividerHeight,
    this.border,
    this.pressColor,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
    this.padding,
    this.onTapClose = true,
    required this.spaceColor,
    required this.openAnimationDuration,
    required this.closeAnimationDuration,
    required this.openAnimation,
    required this.closeAnimation,
    required this.childSize,
    this.openAlignment,
    this.backgroundBlur = 5.0,
    this.leftSpace,
    this.rightSpace,
    this.topSpace,
    this.bottomSpace,
    this.tween,
    required this.spaceBlur,
    this.backgroundDecoration,
    this.divider,
    required this.isTopSpace,
    required this.isLeftSpace,
    required this.animationType,
    required this.slideTween,
  });

  @override
  State<_GrockMenuCore> createState() => _GrockMenuCoreState();
}

class _GrockMenuCoreState extends State<_GrockMenuCore>
    with SingleTickerProviderStateMixin {
  Size widgetSize = Size.zero;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.openAnimationDuration,
    reverseDuration: widget.closeAnimationDuration,
  );
  Animation<double>? _animation;
  final grockMenuController = GrockMenuController();

  double endValue() =>
      widget.animationType == GrockMenuAnimationType.scale ? 1.05 : 1.0;

  void openMenu() {
    _animation = (widget.tween ?? Tween<double>(begin: 0.0, end: 1.0))
        .animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _controller.forward());
  }

  @override
  void initState() {
    super.initState();
    widget.controller?._initState(this);
    openMenu();
  }

  double sigmaValue() => _animation!.value * widget.spaceBlur;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => closeMenu(),
          child: TweenAnimationBuilder(
            duration: _controller.duration!,
            tween: ColorTween(
              begin: Colors.transparent,
              end: widget.spaceColor,
            ),
            builder: (context, Color? color, child) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: sigmaValue(),
                  sigmaY: sigmaValue(),
                ),
                child: Container(
                  color: color,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: widget.isTopSpace ? widget.topSpace : topSpace(),
          left: widget.isLeftSpace ? widget.leftSpace : leftSpace(),
          right: widget.rightSpace,
          bottom: widget.bottomSpace,
          child: GrockWidgetSize(
            callback: (size, offset) => setState(() => widgetSize = size),
            child: animationWidget(_body(context)),
          ).material,
        ),
      ],
    );
  }

  Widget animationWidget(Widget child) {
    return switch (widget.animationType) {
      GrockMenuAnimationType.fade => FadeTransition(
          opacity: _animation!,
          child: child,
        ),
      GrockMenuAnimationType.scale => ScaleTransition(
          scale: _animation!,
          alignment: alignmentAnimation(),
          child: child,
        ),
      GrockMenuAnimationType.slide => SlideTransition(
          position: widget.slideTween.animate(_controller),
          child: child,
        ),
      GrockMenuAnimationType.fadeScale => ScaleTransition(
          scale: _animation!,
          alignment: alignmentAnimation(),
          child: FadeTransition(
            opacity: _animation!,
            child: child,
          ),
        ),
      GrockMenuAnimationType.fadeSlide => SlideTransition(
          position: widget.slideTween.animate(_controller),
          child: FadeTransition(
            opacity: _animation!,
            child: child,
          ),
        ),
      GrockMenuAnimationType.none => child,
    };
  }

  Widget _body(BuildContext context) {
    return DecoratedBox(
      decoration: widget.backgroundDecoration ??
          BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 25,
              )
            ],
          ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.backgroundBlur,
            sigmaY: widget.backgroundBlur,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: widget.maxHeight?.toDouble() ??
                  MediaQuery.of(context).size.height * 0.35,
              minWidth: widget.minWidth,
              maxWidth: widget.minWidth,
            ),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              color: widget.backgroundColor ?? Colors.grey.shade100,
              border: widget.border,
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              child: SingleChildScrollView(
                physics: widget.physics,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.items
                      .mapIndexed<Widget>(
                        (e, i) {
                          return GestureDetector(
                            onTapDown: (_) => setState(() => e.isTapped = true),
                            onTapUp: (_) => setState(() => e.isTapped = false),
                            onTapCancel: () =>
                                setState(() => e.isTapped = false),
                            onTap: () {
                              if (widget.onTapClose) {
                                closeMenu();
                              }
                              widget.onTap?.call(i);
                              e.onTap?.call();
                            },
                            child: e.child ??
                                Container(
                                  width: double.maxFinite,
                                  padding: widget.padding ??
                                      const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: e.isTapped
                                        ? widget.pressColor
                                        : widget.backgroundColor,
                                  ),
                                  child: Row(
                                    children: [
                                      if (e.leading != null) e.leading!,
                                      Expanded(
                                        child: DefaultTextStyle(
                                          style: widget.textStyle ??
                                              context.bodyMedium,
                                          child: e.body ??
                                              Text(
                                                e.text ?? "",
                                                style: e.textStyle ??
                                                    const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                textAlign: widget.textAlign,
                                                maxLines: widget.maxLines,
                                                overflow: widget.textOverflow,
                                              ),
                                        ),
                                      ),
                                      if (e.trailing != null) e.trailing!,
                                    ],
                                  ),
                                ),
                          );
                        },
                      )
                      .toList()
                      .seperatedWidget(
                        widget.divider ??
                            (context, index) => Divider(
                                  height: widget.dividerHeight ?? 1.0,
                                  color: widget.dividerColor ??
                                      CupertinoColors.separator
                                          .withOpacity(0.2),
                                ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void closeMenu() {
    _controller.reverse();
    Future.delayed(widget.closeAnimationDuration, () {
      widget.overlayEntry.remove();
    });
  }

  double topSpace() {
    late double result;
    final screenHeight = context.height;
    final childOffset = widget.offset;
    final childSize = widget.childSize.height;
    final bottomSafeArea = screenHeight - context.bottom;
    if ((bottomSafeArea - widget.offset.dy) < widgetSize.height + childSize) {
      /// Position top
      widget.slideTween = Tween<Offset>(
          begin: Offset(0, childSize.percent(0.26)), end: Offset.zero);
      result = widget.offset.dy - widgetSize.height;
    } else {
      /// Position bottom
      widget.slideTween = Tween<Offset>(
          begin: Offset(0, childSize.percent(-0.26)), end: Offset.zero);
      result = childOffset.dy + childSize;
    }
    return result;
  }

  double leftSpace() {
    late double result;
    final childSize = widget.childSize;
    final childWidth = childSize.width;
    final childOffset = widget.offset;
    if (childOffset.dx > widgetSize.width) {
      result = childOffset.dx - widgetSize.width + (childWidth / 2);
    } else {
      result = (childOffset.dx - childWidth) < 0
          ? childWidth / 2
          : childOffset.dx - childWidth;
    }
    return result;
  }

  Alignment alignmentAnimation() {
    late Alignment result;
    if (widget.openAlignment != null) {
      result = widget.openAlignment!;
    } else {
      final screenHeight = context.height;
      final childOffset = widget.offset;
      if (childOffset.dx > widgetSize.width) {
        if (screenHeight - widgetSize.height < childOffset.dy) {
          result = Alignment.bottomRight;
        } else {
          result = Alignment.topRight;
        }
      } else {
        if (screenHeight - widgetSize.height < childOffset.dy) {
          result = Alignment.bottomLeft;
        } else {
          result = Alignment.topLeft;
        }
      }
    }
    return result;
  }
}

class GrockMenuItem {
  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final Widget? body;
  final TextStyle? textStyle;
  bool isTapped;
  final void Function()? onTap;
  GrockMenuItem({
    /// [text] is the text of the menu item
    this.text,

    /// [leading] is the leading widget of the menu item
    this.leading,

    /// [trailing] is the trailing widget of the menu item
    this.trailing,

    /// [child] is the child widget of the menu item
    this.child,

    /// [body] is the body widget of the menu item
    this.body,

    /// [textStyle] is the text style of the menu item
    this.textStyle,

    /// [onTap] is the function of the menu item
    this.onTap,

    /// [isTapped] is the state of the menu item
    this.isTapped = false,
  });
}

class _GrockMenuItemPressed {
  final GrockMenuItem item;
  bool isPressed = false;
  _GrockMenuItemPressed({
    required this.item,
    required this.isPressed,
  });
}
