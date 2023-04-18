// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class GrockButton extends StatefulWidget {
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Gradient? gradient;
  final double tapOpacity;
  final Color? color;
  final Color elevationColor;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final double? height;
  final double? width;

  const GrockButton({
    Key? key,
    this.child,
    this.tapOpacity = 0.8,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.borderRadius,
    this.borderSide,
    this.gradient,
    this.color,
    this.elevation = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.elevationColor = Colors.black26,
    this.height = 44,
    this.width,
  })  : assert(tapOpacity > 0 || tapOpacity < 1),
        super(key: key);

  @override
  _GrockButtonState createState() => _GrockButtonState();
}

class _GrockButtonState extends State<GrockButton> {
  final _kBorderRadius = const BorderRadius.all(Radius.elliptical(16, 16));
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Material(
        key: widget.key,
        elevation: widget.elevation,
        shadowColor: widget.elevationColor,
        shape: _SquircleBorder(
          radius: widget.borderRadius ?? _kBorderRadius,
          side: widget.borderSide ?? BorderSide.none,
        ),
        child: ClipPath.shape(
          shape: _SquircleBorder(
            radius: widget.borderRadius ?? _kBorderRadius,
          ),
          child: Opacity(
            opacity: _isTapped ? widget.tapOpacity : 1.0,
            child: Material(
              key: widget.key,
              elevation: widget.elevation,
              shadowColor: widget.elevationColor,
              shape: _SquircleBorder(
                radius: widget.borderRadius ?? _kBorderRadius,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onTap,
                onDoubleTap: widget.onDoubleTap,
                onLongPress: widget.onLongPress,
                onTapDown: (details) => setState(() {
                  _isTapped = true;
                }),
                onTapCancel: () => setState(() {
                  _isTapped = false;
                }),
                onTapUp: (details) => setState(() {
                  _isTapped = false;
                }),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: widget.gradient,
                    color: widget.color ?? Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child ??
                          Text(
                            "Button",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
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
}

enum ButtonAnimationEffect {
  shrink(1.0, 0.97),
  enlarge(0.97, 1.0);

  final double begin;
  final double end;

  const ButtonAnimationEffect(this.begin, this.end);

  Animation<double> getTween(AnimationController controller) {
    return Tween<double>(begin: begin, end: end).animate(controller);
  }
}

class _SquircleBorder extends ShapeBorder {
  final BorderSide side;
  final BorderRadius? radius;

  const _SquircleBorder({
    this.side = BorderSide.none,
    this.radius,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return _SquircleBorder(
      side: side.scale(t),
      radius: radius,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _SquirclePath(rect.deflate(side.width), radius);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _SquirclePath(rect, radius);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var path = getOuterPath(rect.deflate(side.width / 2.0),
            textDirection: textDirection);
        canvas.drawPath(path, side.toPaint());
    }
  }
}

Path _SquirclePath(Rect rect, BorderRadius? radius) {
  final c = rect.center;
  double startX = rect.left;
  double endX = rect.right;
  double startY = rect.top;
  double endY = rect.bottom;

  double midX = c.dx;
  double midY = c.dy;

  if (radius == null) {
    return Path()
      ..moveTo(startX, midY)
      ..cubicTo(startX, startY, startX, startY, midX, startY)
      ..cubicTo(endX, startY, endX, startY, endX, midY)
      ..cubicTo(endX, endY, endX, endY, midX, endY)
      ..cubicTo(startX, endY, startX, endY, startX, midY)
      ..close();
  }

  return Path()

    // Start position
    ..moveTo(startX, startY + radius.topLeft.y)

    // top left corner
    ..cubicTo(
      startX,
      startY,
      startX,
      startY,
      startX + radius.topLeft.x,
      startY,
    )
    // top line
    ..lineTo(endX - radius.topRight.x, startY)

    // top right corner
    ..cubicTo(
      endX,
      startY,
      endX,
      startY,
      endX,
      startY + radius.topRight.y,
    )

    // right line
    ..lineTo(endX, endY - radius.bottomRight.y)

    // bottom right corner
    ..cubicTo(
      endX,
      endY,
      endX,
      endY,
      endX - radius.bottomRight.x,
      endY,
    )

    // bottom line
    ..lineTo(startX + radius.bottomLeft.x, endY)

    // bottom left corner
    ..cubicTo(
      startX,
      endY,
      startX,
      endY,
      startX,
      endY - radius.bottomLeft.y,
    )

    // left line
    //..moveTo(startX, startY + radius)
    ..close();
}
