// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, unused_element
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

/// Grock Menu IOS Style Widget
/// A menu tray that can be used to display a menu of items.
/// The menu tray is a container that can be used to display a menu of items.
///
enum GrockMenuTapType { onTap, onLongPress }

class GrockMenuController {
  late _GrockMenuCoreState _state;

  void _initState(_GrockMenuCoreState state) {
    _state = state;
  }

  void close() {
    _state.closeMenu();
  }
}

class GrockMenu extends StatefulWidget {
  final Widget child;
  final double? borderRadius;
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
  final GrockMenuTapType tapType;
  final double? leftSpace;
  final double? rightSpace;
  final double? topSpace;
  final double? bottomSpace;

  /// Default Tween<double>(begin: 0.0, end: 1.1)
  final Tween<double>? startTween;

  /// Default Tween<double>(begin: 1.1, end: 1.0)
  final Tween<double>? endTween;
  final ScrollPhysics? physics;
  final double? dividerHeight;
  final List<GrockMenuItem> items;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry? padding;
  final Function(int value)? onTap;
  final bool onTapClose;
  final BoxBorder? border;
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

  const GrockMenu({
    Key? key,
    required this.child,
    required this.items,
    this.onTap,
    this.controller,
    this.physics,
    this.maxHeight,
    this.minWidth,
    this.borderRadius,
    this.dividerColor,
    this.dividerHeight = 1.0,
    this.tapType = GrockMenuTapType.onTap,
    this.textStyle,
    this.backgroundColor,
    this.border,
    this.pressColor = Colors.white,
    this.maxLines,
    this.textAlign,
    this.textOverflow = TextOverflow.ellipsis,
    this.padding,
    this.onTapClose = true,
    this.spaceColor = Colors.black26,
    this.openAnimationDuration = const Duration(milliseconds: 450),
    this.closeAnimationDuration = const Duration(milliseconds: 350),
    this.openAnimation = Curves.fastOutSlowIn,
    this.closeAnimation = Curves.linear,
    this.openAlignment,
    this.backgroundBlur = 5.0,
    this.leftSpace,
    this.rightSpace,
    this.topSpace,
    this.bottomSpace,
    this.startTween,
    this.endTween,
  }) : super(key: key);

  @override
  State<GrockMenu> createState() => _GrockMenuState();
}

class _GrockMenuState extends State<GrockMenu> {
  Offset _tapPosition = Offset.zero;
  final key = GlobalKey();
  Size? childSize;
  void getOffset() {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _tapPosition = position;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      key: key,
      onTap: widget.tapType == GrockMenuTapType.onTap
          ? () {
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
                    childSize: childSize ?? Size.zero,
                    backgroundBlur: widget.backgroundBlur,
                    leftSpace: widget.leftSpace,
                    rightSpace: widget.rightSpace,
                    topSpace: widget.topSpace,
                    bottomSpace: widget.bottomSpace,
                    startTween: widget.startTween,
                    endTween: widget.endTween,
                  );
                },
              );
              overlayState.insert(_menuOverlayEntry);
            }
          : null,
      onLongPress: widget.tapType == GrockMenuTapType.onLongPress
          ? () {
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
                    childSize: childSize ?? Size.zero,
                    backgroundBlur: widget.backgroundBlur,
                    leftSpace: widget.leftSpace,
                    rightSpace: widget.rightSpace,
                    topSpace: widget.topSpace,
                    bottomSpace: widget.bottomSpace,
                    startTween: widget.startTween,
                    endTween: widget.endTween,
                  );
                },
              );
              overlayState.insert(_menuOverlayEntry);
            }
          : null,
      child: GrockWidgetSize(
          callback: (size, offset) => setState(() => childSize = size), child: widget.child),
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
  double? borderRadius;
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
  final Tween<double>? startTween;
  final Tween<double>? endTween;

  _GrockMenuCore({
    Key? key,
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
    this.startTween,
    this.endTween,
  }) : super(key: key);

  @override
  State<_GrockMenuCore> createState() => _GrockMenuCoreState();
}

class _GrockMenuCoreState extends State<_GrockMenuCore> with SingleTickerProviderStateMixin {
  Size widgetSize = Size.zero;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.openAnimationDuration,
    reverseDuration: widget.closeAnimationDuration,
  );
  Animation<double>? _animation;
  final grockMenuController = GrockMenuController();

  @override
  void initState() {
    super.initState();
    widget.controller?._initState(this);
    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: (widget.startTween ?? Tween<double>(begin: 0.0, end: 1.1))
              .chain(CurveTween(curve: widget.openAnimation)),
          weight: 9,
        ),
        TweenSequenceItem<double>(
          tween: (widget.endTween ?? Tween<double>(begin: 1.1, end: 1.0))
              .chain(CurveTween(curve: widget.closeAnimation)),
          weight: 3,
        ),
      ],
    ).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _controller.forward());
  }

  double sigmaValue() => _animation!.value * widget.backgroundBlur;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => closeMenu(),
            child: TweenAnimationBuilder(
              duration: _controller.duration!,
              tween: ColorTween(begin: Colors.transparent, end: widget.spaceColor),
              builder: (context, Color? color, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigmaValue(), sigmaY: sigmaValue()),
                  child: Container(
                    color: color,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: widget.topSpace ?? topSpace(),
            left: widget.leftSpace ?? leftSpace(),
            right: widget.rightSpace,
            bottom: widget.bottomSpace,
            child: Material(
              type: MaterialType.transparency,
              child: GrockWidgetSize(
                callback: (size, offset) => setState(() => widgetSize = size),
                child: FadeTransition(
                  opacity: _animation!,
                  child: ScaleTransition(
                    scale: _animation!,
                    alignment: alignmentAnimation(),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.maxHeight?.toDouble() ??
                            MediaQuery.of(context).size.height * 0.35,
                        minWidth: widget.minWidth,
                        maxWidth: widget.minWidth,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                        color: widget.backgroundColor ?? Colors.grey.shade100,
                        border: widget.border,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                        child: SingleChildScrollView(
                          physics: widget.physics,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.items.mapIndexed(
                              (e, i) {
                                return GestureDetector(
                                  onTapDown: (_) => setState(() => e.isTapped = true),
                                  onTapUp: (_) => setState(() => e.isTapped = false),
                                  onTapCancel: () => setState(() => e.isTapped = false),
                                  onTap: () {
                                    if (widget.onTapClose) {
                                      closeMenu();
                                    }
                                    widget.onTap?.call(i);
                                    e.onTap?.call();
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: widget.padding ??
                                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color:
                                          e.isTapped ? widget.pressColor : widget.backgroundColor,
                                      border: Border(
                                        bottom: e == widget.items.last
                                            ? BorderSide.none
                                            : BorderSide(
                                                color: widget.dividerColor ??
                                                    CupertinoColors.separator.withOpacity(0.2),
                                                width: widget.dividerHeight ?? 1.0,
                                              ),
                                      ),
                                    ),
                                    child: e.child ??
                                        Row(
                                          children: [
                                            if (e.leading != null) e.leading!,
                                            Expanded(
                                              child: e.body ??
                                                  Text(
                                                    e.text ?? "",
                                                    style: e.textStyle ??
                                                        const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                    textAlign: widget.textAlign,
                                                    maxLines: widget.maxLines,
                                                    overflow: widget.textOverflow,
                                                  ),
                                            ),
                                            if (e.trailing != null) e.trailing!,
                                          ],
                                        ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Curve Animations]
  /// decelerate
  /// bounceOut
  /// ease
  /// easeInOutCubicEmphasized
  /// elasticOut
  /// linearToEaseOut

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
    if (screenHeight - widgetSize.height < childOffset.dy) {
      result = childOffset.dy - widgetSize.height + widget.childSize.height;
    } else {
      result = childOffset.dy + widget.childSize.height;
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
      result = (childOffset.dx - childWidth) < 0 ? childWidth / 2 : childOffset.dx - childWidth;
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
    this.text,
    this.leading,
    this.trailing,
    this.child,
    this.body,
    this.textStyle,
    this.onTap,
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
