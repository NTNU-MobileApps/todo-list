import 'package:flutter/foundation.dart';

/// Return true if the app is currently running on iOS
bool isRunningOniOS() {
  return defaultTargetPlatform == TargetPlatform.iOS;
}
