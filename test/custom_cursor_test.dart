import 'package:flutter_test/flutter_test.dart';
import 'package:custom_cursor/custom_cursor.dart';
import 'package:custom_cursor/custom_cursor_platform_interface.dart';
import 'package:custom_cursor/custom_cursor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockCustomCursorPlatform
//     with MockPlatformInterfaceMixin
//     implements CustomCursorPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final CustomCursorPlatform initialPlatform = CustomCursorPlatform.instance;

//   test('$MethodChannelCustomCursor is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelCustomCursor>());
//   });

//   test('getPlatformVersion', () async {
//     CustomCursor customCursorPlugin = CustomCursor();
//     MockCustomCursorPlatform fakePlatform = MockCustomCursorPlatform();
//     CustomCursorPlatform.instance = fakePlatform;

//     // expect(await customCursorPlugin.getPlatformVersion(), '42');
//   });
// }
