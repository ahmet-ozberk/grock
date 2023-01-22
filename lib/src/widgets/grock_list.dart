// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class GrockList extends StatelessWidget {
  Widget Function(BuildContext, int) itemBuilder;
  int itemCount;
  ScrollPhysics? scrollEffect;
  ScrollController? controller;
  Axis scrollDirection = Axis.vertical;
  EdgeInsetsGeometry? padding;
  bool shrinkWrap = false;
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
      ScrollViewKeyboardDismissBehavior.manual;
  Widget? itemSpace;
  GrockList({
    this.itemCount = 100,
    required this.itemBuilder,
    this.scrollEffect,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.shrinkWrap = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.itemSpace,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      controller: controller,
      physics: scrollEffect ?? const BouncingScrollPhysics(),
      scrollDirection: scrollDirection,
      padding: padding ?? [8, 8, 8, context.bottom].paddingLTRB,
      keyboardDismissBehavior: keyboardDismissBehavior,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) => itemBuilder(context, index),
      separatorBuilder: (context, index) {
        return itemSpace ?? const SizedBox(height: 8);
      },
    );
  }
}
