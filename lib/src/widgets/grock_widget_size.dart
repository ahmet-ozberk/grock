import 'package:flutter/material.dart';

class GrockWidgetSize extends StatefulWidget {
  final Widget child;
  final Function(Size size, Offset offset) callback;
  const GrockWidgetSize({Key? key, required this.child, required this.callback})
      : super(key: key);

  @override
  _GrockWidgetSizeState createState() => _GrockWidgetSizeState();
}

class _GrockWidgetSizeState extends State<GrockWidgetSize> {
  final _key = GlobalKey(debugLabel: "GrockWidgetSizeKey");

  calc() {
    WidgetsBinding.instance.endOfFrame.then((value) {
      final RenderBox? renderBox =
          _key.currentContext?.findRenderObject() as RenderBox?;
      final size = renderBox?.size;
      final offset = renderBox?.localToGlobal(Offset.zero);
      widget.callback(size ?? Size.zero, offset ?? Offset.zero);
    });
  }

  @override
  void initState() {
    super.initState();
    calc();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: _key, child: widget.child);
  }
}
