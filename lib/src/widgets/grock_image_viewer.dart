import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'grock_fade_animation.dart';

const _kRouteDuration = Duration(milliseconds: 300);

class GrockImageViewer extends StatelessWidget {
  const GrockImageViewer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.disposeLevel,
    this.blurOpacity = 10.0,
    this.disableSwipeToDismiss = false,
    this.closeButton,
    this.actions,
  }) : super(key: key);

  final Widget child;

  /// Swipe down to dismiss background color
  final double blurOpacity;

  /// Background in the full screen mode, Colors.black by default
  final Color? backgroundColor;

  /// After what level of drag from top image should be dismissed
  /// high - 300px, middle - 200px, low - 100px
  final DisposeLevel? disposeLevel;

  /// if true the swipe down\up will be disabled
  /// - it gives more predictable behaviour
  final bool disableSwipeToDismiss;

  /// Close button customize
  final Widget? closeButton;

  /// Stay On Top Widgets
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final UniqueKey tag = UniqueKey();
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.transparent.withOpacity(0),
              pageBuilder: (BuildContext context, _, __) {
                return _FullScreenViewer(
                  tag: tag,
                  backgroundColor: backgroundColor,
                  blurOpacity: blurOpacity,
                  disposeLevel: disposeLevel,
                  disableSwipeToDismiss: disableSwipeToDismiss,
                  closeButton: closeButton,
                  actions: actions ?? [],
                  child: child,
                );
              },
            ),
          );
        },
        child: child,
      ),
    );
  }
}

enum DisposeLevel { high, medium, low }

class _FullScreenViewer extends StatefulWidget {
  const _FullScreenViewer({
    Key? key,
    required this.child,
    required this.tag,
    required this.disableSwipeToDismiss,
    this.blurOpacity = 10.0,
    this.backgroundColor,
    this.disposeLevel = DisposeLevel.medium,
    this.closeButton,
    this.actions = const [],
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final DisposeLevel? disposeLevel;
  final UniqueKey tag;
  final bool disableSwipeToDismiss;
  final double blurOpacity;
  final Widget? closeButton;
  final List<Widget> actions;

  @override
  State<_FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<_FullScreenViewer> {
  double? _initialPositionY = 0;

  double? _currentPositionY = 0;

  double _positionYDelta = 0;

  double _opacity = 1;

  double _disposeLimit = 150;

  Duration _animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  setDisposeLevel() {
    if (widget.disposeLevel == DisposeLevel.high) {
      _disposeLimit = 300;
    } else if (widget.disposeLevel == DisposeLevel.medium) {
      _disposeLimit = 200;
    } else {
      _disposeLimit = 100;
    }
  }

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentPositionY = details.globalPosition.dy;
      _positionYDelta = _currentPositionY! - _initialPositionY!;
      setOpacity();
    });
  }

  void _dragStart(DragStartDetails details) {
    setState(() {
      _initialPositionY = details.globalPosition.dy;
    });
  }

  _dragEnd(DragEndDetails details) {
    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _animationDuration = _kRouteDuration;
        _opacity = 1;
        _positionYDelta = 0;
      });

      Future.delayed(_animationDuration).then((_) {
        setState(() {
          _animationDuration = Duration.zero;
        });
      });
    }
  }

  setOpacity() {
    final double tmp = _positionYDelta < 0
        ? 1 - ((_positionYDelta / 1000) * -1)
        : 1 - (_positionYDelta / 1000);
    if (kDebugMode) {
      print(tmp);
    }

    if (tmp > 1) {
      _opacity = 1;
    } else if (tmp < 0) {
      _opacity = 0;
    } else {
      _opacity = tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPosition = 0 + max(_positionYDelta, -_positionYDelta) / 15;
    return Hero(
      tag: widget.tag,
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: _opacity * widget.blurOpacity,
                sigmaY: _opacity * widget.blurOpacity,
              ),
              child: Container(
                color: widget.backgroundColor?.withOpacity(_opacity),
              ),
            ),
            AnimatedPositioned(
              duration: _animationDuration,
              curve: Curves.fastOutSlowIn,
              top: 0 + _positionYDelta,
              bottom: 0 - _positionYDelta,
              left: horizontalPosition,
              right: horizontalPosition,
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                panEnabled: false,
                child: widget.disableSwipeToDismiss
                    ? ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: widget.child,
                      )
                    : _KeymotionGestureDetector(
                        onStart: (details) => _dragStart(details),
                        onUpdate: (details) => _dragUpdate(details),
                        onEnd: (details) => _dragEnd(details),
                        child: widget.child,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                child: GrockFadeAnimation(
                  value: 200,
                  child: widget.closeButton ??
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(CupertinoIcons.clear_thick_circled),
                        iconSize: 32,
                        color: Colors.blueGrey.shade900,
                      ),
                ),
              ),
            ),
            ...widget.actions,
          ],
        ),
      ),
    );
  }
}

class _KeymotionGestureDetector extends StatelessWidget {
  /// @macro
  const _KeymotionGestureDetector({
    Key? key,
    required this.child,
    this.onUpdate,
    this.onEnd,
    this.onStart,
  }) : super(key: key);

  final Widget child;
  final GestureDragUpdateCallback? onUpdate;
  final GestureDragEndCallback? onEnd;
  final GestureDragStartCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(gestures: <Type, GestureRecognizerFactory>{
      VerticalDragGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer()
          ..onStart = onStart
          ..onUpdate = onUpdate
          ..onEnd = onEnd,
        (instance) {},
      ),
      // DoubleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
      //   () => DoubleTapGestureRecognizer()..onDoubleTap = onDoubleTap,
      //   (instance) {},
      // )
    }, child: child);
  }
}
