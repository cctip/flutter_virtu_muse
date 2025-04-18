import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
                launchUrl(Uri.parse('freeprivacypolicy.com/live/0b5f8ca8-d7d0-4a47-9798-ce70518c5a67'));
              }),
              linkItem('Terms of service', (){
                launchUrl(Uri.parse('https://www.freeprivacypolicy.com/live/5b24cde1-cb6b-44e8-a530-4dffc2286408'));
              }),
              // linkItem('Clear Cache', (){ Global.clear(); }),
            ],
          ),
          Spacer(),
          Text('Version 1.0.0', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14, fontWeight: FontWeight.w400)),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16)
        ],
      ),
		);
	}
}

Widget linkItem(text, func) {
  return Container(
    height: 58,
    margin: EdgeInsets.only(top: 16),
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
            fontSize: 16,
            fontWeight: FontWeight.w400
          )),
          Icon(Icons.arrow_forward_ios, color: Colors.white)
        ],
      ),
    ),
  );
}