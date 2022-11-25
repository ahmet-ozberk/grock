// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class GrockDirectSelectionMenu extends StatefulWidget {
  final int? value;
  final List<Widget> items;
  final Color? backgroundColor;
  final double backgroundColorOpacity;
  final Function(int index)? onChanged;
  final String? hintText;
  final IconData icon;
  final Color? iconColor;
  final bool isItemCenter;
  final double? iconSize;
  final TextStyle? valueStyle;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Widget? centerItem;
  final double itemExtent;
  const GrockDirectSelectionMenu({
    super.key,
    this.child,
    this.value,
    this.onChanged,
    required this.items,
    this.icon = Icons.menu,
    this.backgroundColor,
    this.backgroundColorOpacity = 1.6,
    this.isItemCenter = true,
    this.hintText,
    this.iconColor,
    this.iconSize,
    this.valueStyle,
    this.alignment,
    this.padding,
    this.color,
    this.centerItem,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.itemExtent = 50.0,
  }) : assert(backgroundColorOpacity >= 1,
            "backgroundColorOpacity must be at least 1 (backgroundColorOpacity değeri en az 1 olmalıdır)");

  @override
  State<GrockDirectSelectionMenu> createState() => _GrockDirectSelectionMenuState();
}

class _GrockDirectSelectionMenuState extends State<GrockDirectSelectionMenu> with TickerProviderStateMixin {
  /// [variables]
  late FixedExtentScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: widget.value ?? 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubicEmphasized),
    );
    _bgAnimation = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) => onTapDown(details),
      onVerticalDragEnd: (details) => onTapUp(details),
      onVerticalDragUpdate: (details) => onDragUpdate(details),
      child: Container(
        key: widget.key,
        alignment: widget.alignment,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: widget.color,
        decoration: widget.decoration ?? _defaultDecoration(context),
        foregroundDecoration: widget.foregroundDecoration,
        width: widget.width,
        height: widget.height,
        constraints: widget.constraints,
        child: widget.child ?? _defaultChild(context),
      ),
    );
  }

  Widget _defaultChild(BuildContext context) {
    if (widget.value != null) {
      return Row(
        children: [
          Expanded(child: widget.items[widget.value!]),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.iconSize,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: Text(widget.hintText ?? "Seçiniz", style: widget.valueStyle ?? _defaultValueStyle)),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            widget.icon,
            color: widget.iconColor,
            size: widget.iconSize,
          ),
        ),
      ],
    );
  }

  Decoration _defaultDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,
        width: 0.2,
      ),
    );
  }

  final TextStyle _defaultValueStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  void onTapDown(DragStartDetails details) {
    _animationController.forward();
    _scrollController = FixedExtentScrollController(initialItem: widget.value ?? 0);
    Grock.showGrockOverlay(
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox.expand(
            child: AnimatedBuilder(
          animation: _bgAnimation,
          builder: (context, child) {
            return ColoredBox(
              color: (widget.backgroundColor ?? Colors.white)
                  .withOpacity(_animation.value / widget.backgroundColorOpacity),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _bgAnimation.value, sigmaY: _bgAnimation.value),
                child: ScaleTransition(
                  scale: _animation,
                  child: CupertinoScrollbar(
                    child: CupertinoPicker.builder(
                      itemExtent: widget.itemExtent,
                      selectionOverlay: widget.centerItem ?? const CupertinoPickerDefaultSelectionOverlay(),
                      scrollController: _scrollController,
                      childCount: widget.items.length,
                      onSelectedItemChanged: (value) => widget.onChanged?.call(value),
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        if (widget.isItemCenter) {
                          return Center(child: item);
                        }
                        return item;
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        )),
      ),
    );
  }

  void onTapUp(DragEndDetails details) {
    _animationController.reverse();
    Future.delayed(const Duration(milliseconds: 400), () {
      Grock.closeGrockOverlay();
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    _scrollController.jumpTo(_scrollController.offset - details.primaryDelta!);
  }
}
