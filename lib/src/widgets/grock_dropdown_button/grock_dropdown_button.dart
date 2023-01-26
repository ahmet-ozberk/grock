// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';

import 'grock_dropdown_menu_configurate.dart';
import 'grock_dropdown_menu_item.dart';

class GrockDropdownButton<T> extends StatefulWidget {
  List<GrockDropdownMenuItem> items;
  String? value;
  String hintText;
  void Function()? init;
  BoxDecoration? decoration;
  Widget? trailingWidget;
  double? height;
  EdgeInsetsGeometry? padding;
  TextStyle? hintTextStyle;
  TextStyle? textStyle;
  final double? cardBorderRadius;
  GrockDropdownButton({
    required this.items,
    required this.value,
    required this.hintText,
    this.textStyle,
    this.hintTextStyle,
    this.init,
    this.decoration,
    this.trailingWidget,
    this.height,
    this.cardBorderRadius,
    this.padding,
  });
  @override
  State<GrockDropdownButton> createState() => _GrockDropdownButtonState();
}

class _GrockDropdownButtonState extends State<GrockDropdownButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    //_addedItem();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: -pi / 2).animate(_controller)
      ..addListener(() => setState(() {}));
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _returnBody();
  }

  GrockCustomMenu _returnBody() {
    return GrockCustomMenu(
        onTapFunction: _onTap,
        onCancelFunction: _onCancel,
        actions: widget.items,
        borderRadius: widget.cardBorderRadius,
        child: Material(
          type: MaterialType.transparency,
          child: _customContainer(),
        ));
  }

  Container _customContainer() {
    return Container(
      width: double.maxFinite,
      height: widget.height,
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: widget.decoration ?? _defaultDecoration(),
      child: DefaultTextStyle(
        style: widget.value == null ? _hintTextStyle() : _textStyle(),
        child: _itemBody(),
      ),
    );
  }

  Row _itemBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _defaultText()),
        _defaultIcon(),
      ],
    );
  }

  Transform _defaultIcon() {
    return Transform.rotate(
      angle: _animation.value,
      child: widget.trailingWidget ??
          const Icon(Icons.keyboard_arrow_down_rounded),
    );
  }

  Text _defaultText() {
    return Text(
      widget.value ?? widget.hintText,
    );
  }

  BoxDecoration _defaultDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black38, width: 0.25),
      color: Colors.white,
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
    );
  }

  TextStyle _hintTextStyle() =>
      widget.hintTextStyle ??
      Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.grey.shade400,
          );

  TextStyle _textStyle() =>
      widget.textStyle ??
      Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black87,
          );

  void _onTap() {
    widget.init?.call();
    _controller.forward();
  }

  void _onCancel() {
    _controller.reverse();
  }
}
