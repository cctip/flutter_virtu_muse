import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/share_pref.dart';

import 'pages/index.dart';

void main() => SharePref.init().then((e) => runApp(MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      routes: {
        "/": (context) => IndexPage(),
      },
      initialRoute: '/',
    );
  }
}
