import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrockAdaptiveBottomNavigation extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? backgroundColor;
  final double? iconSize;
  final bool useMaterial3;
  final BottomNavigationBarThemeData? androidThemeData;
  final TextStyle? iosTextStyle;
  const GrockAdaptiveBottomNavigation({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.backgroundColor,
    this.iconSize,
    this.useMaterial3 = true,
    this.androidThemeData,
    this.iosTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return switch (platform) {
      TargetPlatform.android => _buildAndroidBottomNavigationBar(),
      TargetPlatform.iOS => _buildIOSBottomNavigationBar(),
      _ => throw UnsupportedError("Unsupported platform $platform"),
    };
  }

  Widget _buildAndroidBottomNavigationBar() {
    return Theme(
      data: ThemeData(
        bottomNavigationBarTheme: androidThemeData,
        useMaterial3: useMaterial3,
      ),
      child: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: backgroundColor,
        iconSize: iconSize ?? 24.0,
      ),
    );
  }

  Widget _buildIOSBottomNavigationBar() {
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(tabLabelTextStyle: iosTextStyle),
      ),
      child: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        activeColor: selectedItemColor,
        inactiveColor: unselectedItemColor ?? _kDefaultTabBarInactiveColor,
        backgroundColor: backgroundColor,
        iconSize: iconSize ?? 30.0,
      ),
    );
  }

  final Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;
}
