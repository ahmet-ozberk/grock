import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GrockScrollEffect extends StatefulWidget {
  GrockScrollEffect({required this.child});
  Widget child;

  @override
  _GrockScrollEffectState createState() => _GrockScrollEffectState();
}

class _GrockScrollEffectState extends State<GrockScrollEffect> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: widget.child);
  }
}
