import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_cursor_method_channel.dart';

abstract class CustomCursorPlatform extends PlatformInterface {
  /// Constructs a CustomCursorPlatform.
  CustomCursorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomCursorPlatform _instance = MethodChannelCustomCursor();

  /// The default instance of [CustomCursorPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomCursor].
  static CustomCursorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomCursorPlatform] when
  /// they register themselves.
  static set instance(CustomCursorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> activateCustomCursor() {
    throw UnimplementedError('activateCustomCursor() has not been implemented.');
  }
}
