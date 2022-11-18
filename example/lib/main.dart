import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:custom_cursor/custom_cursor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomCursorManager.init(Cursors.list);

  runApp(const MyApp());
}

class Cursors {
  static const star = CustomCursor(
    macOs: 'cursors/star.pdf',
    windows: 'cursors/star.cur'
  );

  static List<CustomCursor> get list => [star];
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Row(
            children: [
              MouseRegion(
                cursor: Cursors.star,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(color: Colors.amber),
                ),
              ),
              MouseRegion(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
              ),
              MouseRegion(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.cyan),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
