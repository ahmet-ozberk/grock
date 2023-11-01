import 'package:flutter/material.dart';
import 'package:grock/grock.dart';


class XMenuItem extends StatelessWidget {
  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final double? totalSpace;
  final double? leadingSpace;
  final double? trailingSpace;
  final XMenuItemStyle style;

  const XMenuItem({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.totalSpace = 8,
    this.leadingSpace,
    this.trailingSpace,
    this.style = const XMenuItemStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      borderRadius: style.borderRadius,
      child: Row(
        children: [
          if (leading != null) ...{
            leading!,
            (leadingSpace ?? totalSpace ?? 0).width,
          },
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: style.labelFit,
                child: label,
              ),
            ),
          ),
          if (trailing != null) ...{
            (trailingSpace ?? totalSpace ?? 0).width,
            trailing!,
          },
        ],
      ),
    );
  }
}
