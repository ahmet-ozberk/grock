import 'package:flutter/material.dart';

class GrockButton extends StatefulWidget {
  BorderRadius? borderRadius;
  Gradient? gradient;
  Color? color;
  Color elevationColor;
  double elevation;
  EdgeInsetsGeometry padding;
  Widget? child;
  void Function()? onTap;
  void Function()? onDoubleTap;
  void Function()? onLongPress;
  double? height;
  double? width;

  GrockButton({
    Key? key,
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.borderRadius,
    this.gradient,
    this.color,
    this.elevation = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.elevationColor = Colors.black26,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _GrockButtonState createState() => _GrockButtonState();
}

class _GrockButtonState extends State<GrockButton> {
  final _kBorderRadius = const BorderRadius.all(Radius.elliptical(30, 30));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            key: widget.key,
            elevation: widget.elevation,
            shadowColor: widget.elevationColor,
            shape: _SquircleBorder(
              radius: widget.borderRadius ?? _kBorderRadius,
            ),
            child: ClipPath.shape(
              shape: _SquircleBorder(
                radius: widget.borderRadius ?? _kBorderRadius,
              ),
              child: Material(
                key: widget.key,
                elevation: widget.elevation,
                shadowColor: widget.elevationColor,
                shape: _SquircleBorder(
                  radius: widget.borderRadius ?? _kBorderRadius,
                ),
                child: InkWell(
                  onTap: widget.onTap,
                  onDoubleTap: widget.onDoubleTap,
                  onLongPress: widget.onLongPress,
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
                              "Grock Button",
                              style: Theme.of(context).textTheme.button,
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
        ],
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
