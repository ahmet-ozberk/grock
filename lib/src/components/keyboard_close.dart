import 'package:flutter/material.dart';

class GrockKeyboardClose extends StatelessWidget {
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const GrockKeyboardClose({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}