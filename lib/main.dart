import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/share_pref.dart';

import 'pages/index.dart';
import 'pages/profile.dart';
import 'pages/setting.dart';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: '8MazMv7PCdv2ajzGMYXPNi',
  // appId: appId,
  // showDebug: true,
  timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
  // appInviteOneLink: oneLinkID, // Optional field
  disableAdvertisingIdentifier: false, // Optional field
  disableCollectASA: false, //Optional field
  manualStart: true
); // Optional field

void main() => SharePref.init().then((e) => runApp(MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true
    );
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
