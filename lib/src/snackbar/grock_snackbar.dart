import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class GrockSnackbar {
  GrockSnackbarType grockSnackbarType;
  String message;
  GrockSnackbarShape grockSnackbarShape;
  GrockSnackbarPosition grockSnackbarPosition;
  Color textColor;
  IconData? iconData;
  Function? onTap;
  GrockSnackbar({
    required this.grockSnackbarType,
    required this.message,
    this.grockSnackbarShape = GrockSnackbarShape.mini,
    this.grockSnackbarPosition = GrockSnackbarPosition.bottom,
    this.textColor = Colors.black,
    this.iconData,
    this.onTap,
  });
  show(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: __snackbar(context),
          elevation: 0.0,
          margin: _margin(context),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
        ))
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  _closeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  Widget __snackbar(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap == null ? _closeSnackbar(context) : onTap!(),
      child: itemWidget(context),
    );
  }

  ClipRRect itemWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius(),
      child: backgroundWidget(context),
    );
  }

  Container backgroundWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius(),
      ),
      child: containerWidget(context),
    );
  }

  Container containerWidget(BuildContext context) {
    return Container(
      width: context.w * 0.8,
      decoration: BoxDecoration(
        color: _color().withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          linearWidget(context),
          bodyWidget(),
        ],
      ),
    );
  }

  Container linearWidget(BuildContext context) {
    return Container(
      height: 7,
      width: context.w,
      decoration: BoxDecoration(
        color: _color(),
      ),
    );
  }

  Row bodyWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 15,
          height: 55,
          decoration: BoxDecoration(
            color: _color(),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        messageWidget(),
        iconWidget(),
      ],
    );
  }

  Expanded messageWidget() {
    return Expanded(
      child: Text(
        message,
        style: TextStyle(
          color: textColor.withOpacity(0.8),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding iconWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Icon(
        _icon(),
        color: textColor.withOpacity(0.8),
        size: 22,
      ),
    );
  }

  EdgeInsetsGeometry _margin(BuildContext context) {
    switch (grockSnackbarPosition) {
      case GrockSnackbarPosition.top:
        return EdgeInsets.only(bottom: context.h *0.82-(context.top));
      case GrockSnackbarPosition.bottom:
        return const EdgeInsets.only(bottom: 10);
      default:
        return const EdgeInsets.only(top: 10);
    }
  }

  BorderRadius _borderRadius() {
    switch (grockSnackbarShape) {
      case GrockSnackbarShape.normal:
        return BorderRadius.circular(12.5);
      case GrockSnackbarShape.maxi:
        return BorderRadius.circular(18.5);
      default:
        return BorderRadius.circular(5.0);
    }
  }

  Color _color() {
    switch (grockSnackbarType) {
      case GrockSnackbarType.success:
        return Colors.green;
      case GrockSnackbarType.error:
        return Colors.red;
      case GrockSnackbarType.warning:
        return Colors.orange;
      case GrockSnackbarType.info:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  IconData _icon() {
    if (grockSnackbarType == GrockSnackbarType.success) {
      return Icons.check_circle;
    } else if (grockSnackbarType == GrockSnackbarType.error) {
      return Icons.error;
    } else if (grockSnackbarType == GrockSnackbarType.warning) {
      return Icons.warning;
    } else if (grockSnackbarType == GrockSnackbarType.info) {
      return Icons.info;
    } else {
      return iconData ?? Icons.info;
    }
  }
}

enum GrockSnackbarType { success, error, info, warning }

enum GrockSnackbarShape { mini, normal, maxi }

enum GrockSnackbarPosition { top, bottom }