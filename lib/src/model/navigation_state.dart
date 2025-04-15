import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grock/src/enum/nav_type.dart';

class GrockNavigationService {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>(debugLabel: "Grock Navigation Key");

  static PageRoute<T> _buildPageRoute<T>(
    Widget page,
    NavType? transitionType,
    Duration duration,
    bool fullscreenDialog,
  ) {
    return _PageTransitionManager.buildPageRoute(
      page: page,
      transitionType:
          transitionType ??
          (Platform.isIOS || Platform.isMacOS
              ? NavType.cupertino
              : NavType.material),
      duration: duration,
    );
  }

  static Future to(
    Widget page, {
    NavType? type,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    return navigationKey.currentState!.push(
      _buildPageRoute(page, type, duration, fullscreenDialog),
    );
  }

  static Future toRemove(
    Widget page, {
    NavType? type,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
    RoutePredicate? predicate,
  }) {
    return navigationKey.currentState!.pushAndRemoveUntil(
      _buildPageRoute(page, type, duration, fullscreenDialog),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  static void back({Object? result}) {
    return navigationKey.currentState!.pop(result);
  }
}

/// A utility class for building page routes with various transitions.
class _PageTransitionManager {
  /// Returns a page route with the specified transition type and duration.
  static PageRoute<T> buildPageRoute<T>({
    required Widget page,
    required NavType transitionType,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    switch (transitionType) {
      case NavType.fade:
        return _buildFadeRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.slideLeft:
        return _buildSlideRoute(
          page,
          duration,
          const Offset(1.0, 0.0),
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.slideRight:
        return _buildSlideRoute(
          page,
          duration,
          const Offset(-1.0, 0.0),
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.slideUp:
        return _buildSlideRoute(
          page,
          duration,
          const Offset(0.0, 1.0),
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.slideDown:
        return _buildSlideRoute(
          page,
          duration,
          const Offset(0.0, -1.0),
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.scale:
        return _buildScaleRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.rotate:
        return _buildRotateRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.size:
        return _buildSizeRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.fadeScale:
        return _buildFadeScaleRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.flip:
        return _buildFlipRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.ripple:
        return _buildRippleRoute(
          page,
          duration,
          fullscreenDialog: fullscreenDialog,
        );
      case NavType.cupertino:
        return _buildCupertinoRoute(page, fullscreenDialog: fullscreenDialog);
      case NavType.material:
        return _buildMaterialRoute(page, fullscreenDialog: fullscreenDialog);
    }
  }

  static PageRoute<T> _buildFadeRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildSlideRoute<T>(
    Widget page,
    Duration duration,
    Offset begin, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildScaleRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return ScaleTransition(scale: animation.drive(tween), child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildRotateRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return RotationTransition(turns: animation.drive(tween), child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildSizeRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(sizeFactor: animation, child: child),
        );
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildFadeScaleRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildFlipRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 2.0;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return _RotationYTransition(turns: animation.drive(tween), child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildRippleRoute<T>(
    Widget page,
    Duration duration, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _RippleTransition(animation: animation, child: child);
      },
      transitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildCupertinoRoute<T>(
    Widget page, {
    bool fullscreenDialog = false,
  }) {
    return CupertinoPageRoute<T>(
      builder: (context) => page,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PageRoute<T> _buildMaterialRoute<T>(
    Widget page, {
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute<T>(
      builder: (context) => page,
      fullscreenDialog: fullscreenDialog,
    );
  }
}

class _RotationYTransition extends AnimatedWidget {
  const _RotationYTransition({
    required Animation<double> turns,
    this.child,
  }) : super(listenable: turns);

  final Widget? child;

  Animation<double> get turns => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.rotationY(turns.value * 3.1415927);
    return Transform(transform: transform, child: child);
  }
}

class _RippleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _RippleTransition({
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipOval(clipper: _RippleClipper(animation.value), child: child);
      },
      child: child,
    );
  }
}

class _RippleClipper extends CustomClipper<Rect> {
  final double progress;

  _RippleClipper(this.progress);

  @override
  Rect getClip(Size size) {
    final radius = size.width * 1.5 * progress;
    return Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
  }

  @override
  bool shouldReclip(_RippleClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
