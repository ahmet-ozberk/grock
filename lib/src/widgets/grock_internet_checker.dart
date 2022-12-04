import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../grock_extension.dart';
import '../extensions/padding_extension.dart';
import '../extensions/context_extension.dart';

late OverlayEntry _networkConnect;

class GrockInternetChecker {
  static void internetCheckFunction({
    Function()? onConnect,
    Function()? onDisconnect,
    Color? connectBackgroundColor,
    Color? connectIconColor,
    Icon? connectIcon,
    Widget? connectWidget,
    Duration connectWidgetDuration = const Duration(seconds: 2),
    Widget? disconnectWidget,
    Color? disconnectBackgroundColor,
    Color? disconnectIconColor,
    Icon? disconnectIcon,
    AlignmentGeometry? alignment,
    BoxShape? shape,
  }) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      OverlayState overlayState = Grock.navigationKey.currentState!.overlay!;

      if (result == ConnectivityResult.none) {
        try {
          _networkConnect.remove();
        } catch (e) {}
        _networkConnect = OverlayEntry(builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: alignment ?? Alignment.topRight,
              child: disconnectWidget ?? Container(
                padding: 10.allP,
                margin: EdgeInsets.only(
                  top: context.top + 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: disconnectBackgroundColor ?? Colors.red,
                  shape: shape ?? BoxShape.circle,
                ),
                child: disconnectIcon ??
                    Icon(Icons.wifi_off_rounded,
                        color: disconnectIconColor ?? Colors.white),
              ),
            ),
          );
        });
        overlayState.insert(_networkConnect);
      } else {
        try {
          _networkConnect.remove();
        } catch (e) {}
        _networkConnect = OverlayEntry(builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: alignment ?? Alignment.topRight,
              child: connectWidget ?? Container(
                padding: 10.allP,
                margin: EdgeInsets.only(
                  top: context.top + 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: connectBackgroundColor ?? Colors.green,
                  shape: shape ?? BoxShape.circle,
                ),
                child: connectIcon ?? Icon(Icons.wifi_rounded, color: connectIconColor ?? Colors.white),
              ),
            ),
          );
        });
        overlayState.insert(_networkConnect);
        Future.delayed(connectWidgetDuration, () {
          try {
            _networkConnect.remove();
          } catch (e) {}
        });
      }
    });
  }
}
