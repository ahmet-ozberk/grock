import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart' as Foundation;

class InfoGrock {
  static Future<String> appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static bool isDebugMode() {
    return Foundation.kDebugMode;
  }

  static bool isReleaseMode() {
    return Foundation.kReleaseMode;
  }

  static bool isProfileMode() {
    return Foundation.kProfileMode;
  }
}
