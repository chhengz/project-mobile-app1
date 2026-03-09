import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String _androidEmulatorUrl = "http://10.0.2.2:4000";
  static const String _localUrl = "http://localhost:4000";

  static String get baseUrl {
    if (kIsWeb) {
      return _localUrl;
    }

    // Most mobile simulator/device setups use Android emulator loopback.
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _androidEmulatorUrl;
    }

    return _localUrl;
  }
}
