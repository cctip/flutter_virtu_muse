import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: false,
            title: Text('Settings', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ))
          ),
          Column(
            children: [
              linkItem('Policy privacy', (){
                launchUrl(Uri.parse('https://www.freeprivacypolicy.com/live/f8f77e38-89e6-4d25-85bb-25809cac41c9'));
              }),
              linkItem('Terms of service', (){
                launchUrl(Uri.parse('https://www.freeprivacypolicy.com/live/2d59955b-496a-4833-8b7d-52266a5b8936'));
              }),
              // linkItem('Clear Cache', (){ Global.clear(); }),
            ],
          ),
          Spacer(),
          Text('Version 1.0.0', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: kBottomNavigationBarHeight)
        ],
      ),
		);
	}
}

Widget linkItem(text, func) {
  return Container(
    height: 58,
    decoration: BoxDecoration(color: Colors.black),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        overlayColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0, // 阴影
        backgroundColor: Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        )
      ),
      onPressed: func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold
          )),
          Icon(Icons.arrow_forward_ios, color: Colors.white)
        ],
      ),
    ),
  );
}