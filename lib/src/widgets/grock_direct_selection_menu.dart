// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../grock_extension.dart';

enum GrockDirectionPressStyle {
  tap,
  swipe,
}

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
  final Alignment? alignment;
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
  final double centerItemOpacity;
  final GrockDirectionPressStyle pressStyle;
  const GrockDirectSelectionMenu({
    super.key,
    this.child,
    this.value,
    this.onChanged,
    required this.items,
    this.icon = Icons.menu,
    this.backgroundColor = Colors.black,
    this.backgroundColorOpacity = 0.4,
    this.isItemCenter = true,
    this.hintText,
    this.iconColor,
    this.iconSize,
    this.valueStyle,
    this.alignment = Alignment.bottomCenter,
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
    this.centerItemOpacity = 0.3,
    this.pressStyle = GrockDirectionPressStyle.swipe,
  })  : assert(backgroundColorOpacity >= 0 && backgroundColorOpacity <= 1,
            "The backgroundColorOpacity value must be at least 0, and at most 1 (backgroundColorOpacity değeri en az 0, en fazla 1 olmalıdır)"),
        assert(centerItemOpacity >= 0 && centerItemOpacity <= 1,
            "The centerItemOpacity value must be at least 0, and at most 1 (centerItemOpacity değeri en az 0, en fazla 1 olmalıdır)");

  @override
  State<GrockDirectSelectionMenu> createState() =>
      _GrockDirectSelectionMenuState();
}

class _GrockDirectSelectionMenuState extends State<GrockDirectSelectionMenu>
    with TickerProviderStateMixin {
  /// [variables]
  late FixedExtentScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _blurAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController =
        FixedExtentScrollController(initialItem: widget.value ?? 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _animation = _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.1)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 9,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.1, end: 1.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 3,
        ),
      ],
    ).animate(_animationController);
    _blurAnimation = Tween(
      begin: 0.0,
      end: 20.0,
    ).animate(_animationController);
    _opacityAnimation = Tween(
      begin: 0.0,
      end: widget.backgroundColorOpacity,
    ).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final tapStyle = widget.pressStyle == GrockDirectionPressStyle.tap;
    return GestureDetector(
      onTap: tapStyle ? () => onTapDown() : null,
      onTapDown: !tapStyle ? (details) => onTapDown() : null,
      onVerticalDragStart: !tapStyle ? (details) => onTapDown() : null,
      onVerticalDragEnd: !tapStyle ? (details) => onTapUp(details) : null,
      onVerticalDragUpdate:
          !tapStyle ? (details) => onDragUpdate(details) : null,
      child: Container(
        key: widget.key,
        alignment: widget.alignment,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
        Expanded(
            child: Text(widget.hintText ?? "Seçiniz",
                style: widget.valueStyle ?? _defaultValueStyle)),
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
      color: widget.color,
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

  void onTapDown() {
    _animationController.forward();
    _scrollController =
        FixedExtentScrollController(initialItem: widget.value ?? 0);
    Grock.showGrockOverlay(
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox.expand(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => GestureDetector(
              onTap: widget.pressStyle == GrockDirectionPressStyle.tap
                  ? () => onTapUp(DragEndDetails())
                  : null,
              child: ColoredBox(
                color:
                    widget.backgroundColor!.withOpacity(_opacityAnimation.value),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: _blurAnimation.value, sigmaY: _blurAnimation.value),
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: widget.alignment!,
                    child: CupertinoPicker.builder(
                      itemExtent: widget.itemExtent,
                      selectionOverlay: widget.centerItem ??
                          CupertinoPickerDefaultSelectionOverlay(
                              background: Colors.white
                                  .withOpacity(widget.centerItemOpacity)),
                      scrollController: _scrollController,
                      childCount: widget.items.length,
                      onSelectedItemChanged: (value) =>
                          widget.onChanged?.call(value),
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
            ),
          ),
        ),
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
