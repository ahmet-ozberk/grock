import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GrockHList<T> extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool reverse;
  EdgeInsetsGeometry? padding;
  bool? primary;
  ScrollPhysics? physics;
  ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  Clip clipBehavior;
  String? restorationId;
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  double? listHeight;
  double? itemHeight;
  double? itemWidth;

  GrockHList(
      {Key? key,
      required this.itemBuilder,
      this.itemCount = 100,
      this.listHeight,
      this.itemHeight,
      this.itemWidth,
      this.reverse = false,
      this.padding = EdgeInsets.zero,
      this.primary,
      this.physics,
      this.controller,
      this.dragStartBehavior = DragStartBehavior.start,
      this.clipBehavior = Clip.hardEdge,
      this.restorationId,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual})
      : super(key: key);

  @override
  _GrockHListState createState() => _GrockHListState();
}

class _GrockHListState extends State<GrockHList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.listHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: widget.reverse,
        padding: widget.padding,
        primary: widget.primary,
        physics: widget.physics,
        controller: widget.controller,
        dragStartBehavior: widget.dragStartBehavior,
        clipBehavior: widget.clipBehavior,
        restorationId: widget.restorationId,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        child: Row(
          children: List.generate(widget.itemCount, (index) {
            return SizedBox(
                height: widget.itemHeight,
                width: widget.itemWidth,
                child: widget.itemBuilder(context, index));
          }),
        ),
      ),
    );
  }
}
