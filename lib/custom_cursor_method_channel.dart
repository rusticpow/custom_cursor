import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_cursor_platform_interface.dart';

/// An implementation of [CustomCursorPlatform] that uses method channels.
class MethodChannelCustomCursor extends CustomCursorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_cursor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> activateCustomCursor() {
    return methodChannel.invokeMethod('activateCustomCursor');
  }
}
