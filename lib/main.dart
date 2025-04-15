import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/share_pref.dart';

import 'pages/index.dart';
import 'pages/profile.dart';
import 'pages/setting.dart';

void main() => SharePref.init().then((e) => runApp(MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      home: IndexPage(),
      getPages: [
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/setting', page: () => SettingPage()),
      ],
    );
  }
}
