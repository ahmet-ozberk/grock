import 'package:flutter/material.dart';

class GrockKeyboardClose extends StatelessWidget {
  final Widget child;
  const GrockKeyboardClose({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
