import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class GrockDropdownMenuItem extends StatefulWidget {
  const GrockDropdownMenuItem({
    Key? key,
    required this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    this.trailingWidget,
    this.constraints,
    this.decoration,
    this.padding,
    this.isCenterChild = false,
  })  : assert(child != null),
        assert(isDefaultAction != null),
        assert(isDestructiveAction != null),
        super(key: key);

  final Text child;

  final bool isCenterChild;

  final bool isDefaultAction;

  final bool isDestructiveAction;

  final Function(String? value)? onPressed;

  final Widget? trailingWidget;

  final BoxConstraints? constraints;

  final BoxDecoration? decoration;

  final EdgeInsetsGeometry? padding;

  @override
  State<GrockDropdownMenuItem> createState() => _GrockDropdownMenuItemState();
}

class _GrockDropdownMenuItemState extends State<GrockDropdownMenuItem> {
  static const Color _kBackgroundColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFEEEEEE),
    darkColor: Color(0xFF212122),
  );
  static const Color _kBackgroundColorPressed =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFDDDDDD),
    darkColor: Color(0xFF3F3F40),
  );
  static const double _kButtonHeight = 46.0;
  static const TextStyle _kActionSheetActionStyle = TextStyle(
    fontFamily: '.SF UI Text',
    inherit: false,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: CupertinoColors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  final GlobalKey _globalKey = GlobalKey();
  bool _isPressed = false;

  void onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  TextStyle get _textStyle {
    if (widget.isDefaultAction) {
      return _kActionSheetActionStyle.copyWith(
        fontWeight: FontWeight.w600,
      );
    }
    if (widget.isDestructiveAction) {
      return _kActionSheetActionStyle.copyWith(
        color: CupertinoColors.destructiveRed,
      );
    }
    return _kActionSheetActionStyle.copyWith(
        color: CupertinoDynamicColor.resolve(CupertinoColors.label, context));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _globalKey,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!(widget.child.data);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: ConstrainedBox(
        constraints: widget.constraints ??
            const BoxConstraints(
              minHeight: _kButtonHeight,
            ),
        child: Semantics(
          button: true,
          child: Container(
            decoration: widget.decoration ??
                BoxDecoration(
                  color: _isPressed
                      ? CupertinoDynamicColor.resolve(
                          _kBackgroundColorPressed, context)
                      : CupertinoDynamicColor.resolve(
                          _kBackgroundColor, context),
                ),
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
            child: DefaultTextStyle(
              style: _textStyle,
              child: Row(
                mainAxisAlignment: widget.isCenterChild == true &&
                        widget.trailingWidget == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.isCenterChild == true &&
                      widget.trailingWidget != null)
                    Opacity(
                      opacity: 0,
                      child: widget.trailingWidget,
                    ),
                  Flexible(
                    child: widget.child,
                  ),
                  if (widget.trailingWidget != null) widget.trailingWidget!
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? onChange() {
    return widget.child.data;
  }
}
