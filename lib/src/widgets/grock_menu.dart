import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

late OverlayEntry _menuOverlayEntry;

extension GrockMenuExtension on GrockMenu {
  static void close() {
    try {
      _menuOverlayEntry.remove();
    } catch (e) {
      log("GrockMenu zaten açık değildi. (GrockMenu wasn't open anyway.)",
          name: "GrockMenu");
    }
  }
}

class GrockMenu extends StatefulWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final double? borderRadius;
  final double? blur;
  final Color? backgroundColor;
  final Color? pressColor;
  final List<GrockMenuItem>? items;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry? padding;
  final Function(int value)? onTap;
  final Widget Function(BuildContext, int)? dividerBuilder;
  bool onTapClose;
  final BoxBorder? border;
  double? elevation;
  Color? shadowColor;
  Color spaceColor;

  GrockMenu({
    Key? key,
    required this.child,
    this.items,
    this.onTap,
    this.dividerBuilder,
    this.constraints,
    this.borderRadius,
    this.elevation = 0,
    this.shadowColor = Colors.black26,
    this.blur,
    this.backgroundColor,
    this.border,
    this.pressColor,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
    this.padding,
    this.onTapClose = true,
    this.spaceColor = Colors.transparent,
  }) : super(key: key);

  static void close() => GrockMenuExtension.close();

  @override
  State<GrockMenu> createState() => _GrockMenuState();
}

class _GrockMenuState extends State<GrockMenu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OverlayState overlayState = Grock.navigationKey.currentState!.overlay!;
        overlayState.insert(_menuOverlayEntry);
      },
      onTapUp: (details) {
        _menuOverlayEntry = OverlayEntry(
          builder: (context) {
            return _GrockMenuCore(
              overlayEntry: _menuOverlayEntry,
              details: details,
              items: widget.items,
              onTap: widget.onTap,
              dividerBuilder: widget.dividerBuilder,
              constraints: widget.constraints,
              borderRadius: widget.borderRadius,
              blur: widget.blur,
              backgroundColor: widget.backgroundColor,
              pressColor: widget.pressColor,
              maxLines: widget.maxLines,
              textAlign: widget.textAlign,
              textOverflow: widget.textOverflow,
              padding: widget.padding,
              onTapClose: widget.onTapClose,
              border: widget.border,
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              spaceColor: widget.spaceColor,
            );
          },
        );
      },
      child: widget.child,
    );
  }
}

class _GrockMenuCore extends StatefulWidget {
  TapUpDetails details;
  OverlayEntry overlayEntry;
  BoxConstraints? constraints;
  double? borderRadius;
  double? blur;
  Color? backgroundColor;
  double? elevation;
  Color? shadowColor;
  Color? pressColor;
  List<GrockMenuItem>? items;
  int? maxLines;
  BoxBorder? border;
  TextAlign? textAlign;
  TextOverflow? textOverflow;
  EdgeInsetsGeometry? padding;
  Function(int value)? onTap;
  Widget Function(BuildContext, int)? dividerBuilder;
  bool onTapClose;
  Color spaceColor;

  _GrockMenuCore({
    Key? key,
    required this.overlayEntry,
    required this.details,
    this.items,
    this.onTap,
    this.dividerBuilder,
    this.constraints,
    this.borderRadius,
    this.elevation = 0,
    this.shadowColor = Colors.black26,
    this.blur,
    this.backgroundColor,
    this.border,
    this.pressColor,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
    this.padding,
    this.onTapClose = true,
    required this.spaceColor,
  }) : super(key: key);

  @override
  State<_GrockMenuCore> createState() => _GrockMenuCoreState();
}

class _GrockMenuCoreState extends State<_GrockMenuCore>
    with SingleTickerProviderStateMixin {
  // [POSITION VARİABLES]
  double? _top;
  double? _bottom;
  double? _left;
  double? _right;

  // [DECORATİON VARİABLES]
  double _kCornerRadius = 14.0;
  double _kBlurAmount = 20.0;
  Color _kDialogColor = const CupertinoDynamicColor.withBrightness(
    color: Color(0xCCF2F2F2),
    darkColor: Color(0xBF1E1E1E),
  );
  Color _kPressedColor = CupertinoDynamicColor.withBrightness(
    color: Colors.grey.shade300,
    darkColor: const Color(0xFF2E2E2E),
  );

  // [CORE VARİABLES]
  final bool _isPressed = false;
  final _globalKey = GlobalKey();
  late Offset _globalOffset;
  Alignment _scaleAlign = Alignment.center;
  late AnimationController _controller;
  late Animation<double> _animation;
  final kAnimateDuration = const Duration(milliseconds: 50);
  final List<_GrockMenuItemPressed> _items = [];

  @override
  void initState() {
    _initFunction();
    super.initState();
  }

  void _initFunction() {
    _itemsResult();
    _globalOffset = widget.details.globalPosition;
    _variableMatch();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculatingPosition());
    _animateStart();
  }

  void _itemsResult() {
    widget.items?.forEach((element) {
      _items.add(_GrockMenuItemPressed(
        item: element,
        isPressed: false,
      ));
    });
  }

  void _variableMatch() {
    if (widget.borderRadius != null) {
      _kCornerRadius = widget.borderRadius!;
    }
    if (widget.blur != null) {
      _kBlurAmount = widget.blur!;
    }
    if (widget.backgroundColor != null) {
      _kDialogColor = widget.backgroundColor!;
    }

    if (widget.pressColor != null) {
      _kPressedColor = widget.pressColor!;
    }
    widget.blur ??= _kBlurAmount;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _animateClosed();
        Future.delayed(kAnimateDuration, () => widget.overlayEntry.remove());
      },
      child: ColoredBox(
        color: widget.spaceColor,
        child: Stack(
          children: [
            Positioned(
              top: _top,
              bottom: _bottom,
              left: _left,
              right: _right,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PhysicalModel(
                    color: Colors.transparent,
                    elevation: widget.elevation!,
                    shadowColor: widget.shadowColor!,
                    borderRadius: BorderRadius.circular(_kCornerRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AnimatedOpacity(
                        duration: kAnimateDuration,
                        opacity: _animation.value,
                        child: ClipRRect(
                          key: _globalKey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(_kCornerRadius)),
                          child: Material(
                            borderRadius: BorderRadius.all(
                                Radius.circular(_kCornerRadius)),
                            type: MaterialType.transparency,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: _kBlurAmount, sigmaY: _kBlurAmount),
                              child: Container(
                                constraints: widget.constraints ??
                                    BoxConstraints(
                                      maxWidth: context.isPhone
                                          ? size.width * 0.6
                                          : 250,
                                      maxHeight: _items.length > 9
                                          ? size.height * 0.45
                                          : double.infinity,
                                    ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(_kCornerRadius)),
                                  color: CupertinoDynamicColor.resolve(
                                      _kDialogColor, context),
                                  border: widget.border,
                                ),
                                child: _items.length > 9
                                    ? CupertinoScrollbar(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return dividerBuilderFunction(
                                                context, index);
                                          },
                                          itemCount: _items.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTapDown: (details) {
                                                onTapDownFunction(index);
                                              },
                                              onTapUp: (details) {
                                                onTapUpFunction(index);
                                              },
                                              onTapCancel: () {
                                                onTapCancelFunction(index);
                                              },
                                              onTap: () {
                                                onTapFunction(index);
                                              },
                                              child: DefaultTextStyle(
                                                style: _items[index]
                                                        .item
                                                        .textStyle ??
                                                    Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(fontSize: 15),
                                                textAlign: widget.textAlign,
                                                maxLines: widget.maxLines,
                                                overflow: widget.textOverflow ??
                                                    TextOverflow.ellipsis,
                                                child: _GrockMenuContainer(
                                                    index: index,
                                                    widget: widget,
                                                    items: _items,
                                                    kPressedColor:
                                                        _kPressedColor),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return dividerBuilderFunction(
                                              context, index);
                                        },
                                        itemCount: _items.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTapDown: (details) {
                                              onTapDownFunction(index);
                                            },
                                            onTapUp: (details) {
                                              onTapUpFunction(index);
                                            },
                                            onTapCancel: () {
                                              onTapCancelFunction(index);
                                            },
                                            onTap: () {
                                              onTapFunction(index);
                                            },
                                            child: DefaultTextStyle(
                                              style: _items[index]
                                                      .item
                                                      .textStyle ??
                                                  Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(fontSize: 15),
                                              textAlign: widget.textAlign,
                                              maxLines: widget.maxLines,
                                              overflow: widget.textOverflow ??
                                                  TextOverflow.ellipsis,
                                              child: _GrockMenuContainer(
                                                  index: index,
                                                  widget: widget,
                                                  items: _items,
                                                  kPressedColor:
                                                      _kPressedColor),
                                            ),
                                          );
                                        },
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
            ),
          ],
        ),
      ),
    );
  }

  Widget dividerBuilderFunction(BuildContext context, int index) {
    if (widget.dividerBuilder != null) {
      return widget.dividerBuilder!(context, index);
    } else {
      return const Divider(
        color: CupertinoColors.separator,
        thickness: 1,
        height: 0,
      );
    }
  }

  void onTapFunction(int index) {
    _items[index].item.onTap?.call();
    widget.onTap?.call(index);
    if (widget.onTapClose) {
      widget.overlayEntry.remove();
    }
  }

  void onTapCancelFunction(int index) {
    setState(() {
      _items[index].isPressed = false;
    });
  }

  void onTapUpFunction(int index) {
    setState(() {
      _items[index].isPressed = false;
    });
  }

  void onTapDownFunction(int index) {
    setState(() {
      _items[index].isPressed = true;
    });
  }

  void _calculatingPosition() {
    final size = MediaQuery.of(context).size;
    final widgetSize = _globalKey.currentContext!.size!;
    setState(() {
      /// [horizontal]
      if (_globalOffset.dx > size.width * 0.34 &&
          _globalOffset.dx > widgetSize.width) {
        _right = (size.width - _globalOffset.dx).abs();
      } else {
        if (widgetSize.width < _globalOffset.dx) {
          _left = _globalOffset.dx;
        } else {
          _left = _globalOffset.dx / 2;
        }
      }

      /// [vertical]
      if ((_globalOffset.dy + widgetSize.height) > size.height) {
        _bottom = (size.height - _globalOffset.dy);
      } else {
        _top = _globalOffset.dy;
      }

      if (_right != null && _top != null) {
        _scaleAlign = Alignment.topRight;
      } else if (_right != null && _bottom != null) {
        _scaleAlign = Alignment.bottomRight;
      } else if (_left != null && _top != null) {
        _scaleAlign = Alignment.topLeft;
      } else if (_left != null && _bottom != null) {
        _scaleAlign = Alignment.bottomLeft;
      }
    });
  }

  _animateStart() {
    _controller = AnimationController(
      vsync: this,
      duration: kAnimateDuration,
      reverseDuration: kAnimateDuration,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  _animateClosed() {
    _controller.reverse();
  }
}

class _GrockMenuContainer extends StatelessWidget {
  const _GrockMenuContainer({
    Key? key,
    required this.widget,
    required List<_GrockMenuItemPressed> items,
    required Color kPressedColor,
    required this.index,
  })  : _items = items,
        _kPressedColor = kPressedColor,
        super(key: key);

  final _GrockMenuCore widget;
  final List<_GrockMenuItemPressed> _items;
  final Color _kPressedColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: _items[index].isPressed ? _kPressedColor : null,
      ),
      child: _items[index].item.child ??
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: _items[index].item.leading == null ? 0 : 8),
                child: _items[index].item.leading ?? const SizedBox(),
              ),
              Expanded(
                child: Text(
                  _items[index].item.text ?? "",
                  style: _items[index].item.textStyle,
                ),
              ),
              _items[index].item.trailing ?? const SizedBox(),
            ],
          ),
    );
  }
}

class GrockMenuItem {
  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final Widget? body;
  final TextStyle? textStyle;
  final void Function()? onTap;
  GrockMenuItem({
    this.text,
    this.leading,
    this.trailing,
    this.child,
    this.body,
    this.textStyle,
    this.onTap,
  });
}

class _GrockMenuItemPressed {
  final GrockMenuItem item;
  bool isPressed = false;
  _GrockMenuItemPressed({
    required this.item,
    required this.isPressed,
  });
}
