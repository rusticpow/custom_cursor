import 'dart:ui';

import 'package:custom_cursor/custom_cursor_method_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_cursor_platform_interface.dart';

class CustomCursor extends MouseCursor {
  final String kind = "custom";
  final Uint8List imageBytes;

  const CustomCursor({required this.imageBytes});

  @override
  MouseCursorSession createSession(int device) => _CustomCursorSession(this, device);

  @override
  String get debugDescription => '${objectRuntimeType(this, 'CustomCursor')}($kind)';
}

class _CustomCursorSession extends MouseCursorSession {
  _CustomCursorSession(CustomCursor super.cursor, super.device);

  @override
  CustomCursor get cursor => super.cursor as CustomCursor;

  @override
  Future<void> activate() {
    return MethodChannelCustomCursor().methodChannel.invokeMethod<void>(
      'activateCustomCursor',
      <String, dynamic>{
        'bytes': cursor.imageBytes
      },
    );
  }

  @override
  void dispose() {/* Nothing */}
}
