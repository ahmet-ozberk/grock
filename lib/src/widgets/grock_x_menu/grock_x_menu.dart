import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

import 'grock_x_menu_overlay.dart';

typedef GrockXMenuController = XMenuController;

class GrockXMenu extends StatefulWidget {
  final Widget child;
  final List<XMenuItem>? items;
  final VoidCallback? onChildTap;
  final VoidCallback? onChildLongPress;
  final VoidCallback? onChildDoubleTap;
  final XMenuInkStyle inkStyle;
  final XMenuPositionStyle positionStyle;
  final XMenuAnimationStyle animationStyle;
  final XMenuBarrierStyle barrierStyle;
  final XMenuPopupStyle popupStyle;
  final XMenuAnimationBuilder? animationBuilder;
  final GrockXMenuController? controller;
  const GrockXMenu({
    super.key,
    required this.child,
    this.items,
    this.onChildTap,
    this.onChildLongPress,
    this.onChildDoubleTap,
    this.inkStyle = const XMenuInkStyle(),
    this.positionStyle = const XMenuPositionStyle(),
    this.animationStyle = const XMenuAnimationStyle(),
    this.barrierStyle = const XMenuBarrierStyle(),
    this.popupStyle = const XMenuPopupStyle(),
    this.animationBuilder,
    this.controller,
  });

  @override
  State<GrockXMenu> createState() => _GrockXMenuState();
}

class _GrockXMenuState extends State<GrockXMenu> {
  late final Size childSize;
  late final Offset childOffset;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: widget.inkStyle.focusColor,
      hoverColor: widget.inkStyle.hoverColor,
      highlightColor: widget.inkStyle.highlightColor,
      overlayColor: widget.inkStyle.overlayColor,
      splashColor: widget.inkStyle.splashColor,
      splashFactory: widget.inkStyle.splashFactory,
      radius: widget.inkStyle.radius,
      borderRadius: widget.inkStyle.borderRadius,
      customBorder: widget.inkStyle.customBorder,
      enableFeedback: widget.inkStyle.enableFeedback,
      focusNode: widget.inkStyle.focusNode,
      canRequestFocus: widget.inkStyle.canRequestFocus,
      onFocusChange: widget.inkStyle.onFocusChange,
      autofocus: widget.inkStyle.autofocus ?? false,
      statesController: widget.inkStyle.statesController,
      onTap: widget.inkStyle.inkType == XMenuInkType.tap ? showMenu : null,
      onLongPress:
          widget.inkStyle.inkType == XMenuInkType.longPress ? showMenu : null,
      onDoubleTap:
          widget.inkStyle.inkType == XMenuInkType.doubleTap ? showMenu : null,
      child: GrockWidgetSize(
        callback: (size, offset) => setState(() {
          childSize = size;
          childOffset = offset;
        }),
        child: widget.child,
      ),
    );
  }

  void showMenu() {
    switch (widget.inkStyle.inkType) {
      case XMenuInkType.tap:
        widget.onChildTap?.call();
        break;
      case XMenuInkType.longPress:
        widget.onChildLongPress?.call();
        break;
      case XMenuInkType.doubleTap:
        widget.onChildDoubleTap?.call();
        break;
      default:
        break;
    }
    Grock.showGrockOverlay(
      child: GrockXMenuOverlay(
        items: widget.items ?? [],
        childSize: childSize,
        childOffset: childOffset,
        positionStyle: widget.positionStyle,
        animationBuilder: widget.animationBuilder,
        animationStyle: widget.animationStyle,
        barrierStyle: widget.barrierStyle,
        popupStyle: widget.popupStyle,
        controller: widget.controller,
      ),
    );
  }
}
