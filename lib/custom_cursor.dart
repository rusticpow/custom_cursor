import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:custom_cursor/custom_cursor_method_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class CursorObject {
  final Uint8List? bytes;
  final String? curFile;

  const CursorObject({this.bytes, this.curFile});
}

class CustomCursorManager {
  static final Map<String, CursorObject> _cursors = <String, CursorObject>{};

  CursorObject? getCursor(CustomCursor cursor) {
    return _cursors[cursor.macOs!];
  }

  static Future<void> init(List<CustomCursor> cursors) async {
    if (!Platform.isMacOS && !Platform.isWindows) {
      throw Exception("Mac OS, Windows platforms supported only");
    }

    for (final cursor in cursors) {
      if (Platform.isMacOS && cursor.macOs != null) {
        _cursors[cursor.macOs!] = CursorObject(bytes: (await rootBundle.load(cursor.macOs!)).buffer.asUint8List());
      } else if (Platform.isWindows && cursor.windows != null) {
        final bytes = (await rootBundle.load(cursor.windows!)).buffer.asUint8List();
        final curFileName = "${(await getApplicationSupportDirectory())}/{${cursor.windows}}";
        final file = File(curFileName);
        if (!await file.exists()) {
          await file.create(recursive: true);
        }

        await file.writeAsBytes(bytes);
        _cursors[cursor.windows!] = CursorObject(curFile: curFileName);
      }
    }
  }
}

class CustomCursor extends MouseCursor {
  final String kind = "custom";
  final String? macOs;
  final String? windows;

  const CustomCursor({this.macOs, this.windows});

  @override
  MouseCursorSession createSession(int device) => _CustomCursorSession(this, device);

  @override
  String get debugDescription => '${objectRuntimeType(this, 'CustomCursor')}($kind)';
}

class _CustomCursorSession extends MouseCursorSession {
  static final CustomCursorManager _manager = CustomCursorManager();
  _CustomCursorSession(CustomCursor super.cursor, super.device);

  @override
  CustomCursor get cursor => super.cursor as CustomCursor;

  @override
  Future<void> activate() async {
    final cursor = _manager.getCursor(this.cursor);
    if (cursor == null) {
      throw Exception("Cursor did not init properly");
    }

    return await MethodChannelCustomCursor().methodChannel.invokeMethod<void>(
      'activateCustomCursor',
      <String, dynamic>{'bytes': cursor.bytes},
    );
  }

  @override
  void dispose() {/* Nothing */}
}
