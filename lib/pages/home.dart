import 'package:flutter/material.dart';
import '/widgets/common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return CommonPage(
      child: Stack(
        alignment: Alignment.center,
        children: [
          __content(),
          __footerBtn()
        ],
      )
    );
  }

  Widget __content() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        __domainItem(icon: 'poker', text: 'Flip'),
        Column(
          children: [
            __domainItem(icon: 'switch', text: 'Switch'),
            SizedBox(height: 16),
            __domainItem(icon: 'badge', text: 'Badge'),
          ],
        )
      ],
    );
  }
  Widget __domainItem({required String icon, required String text}) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 22, 26, 0.24),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          ),
          child: Image.asset('assets/icons/$icon.png'),
        ),
        Container(
          width: 64,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 22, 26, 0.4),
            border: Border(bottom: BorderSide(color: Color(0xFFFF006C)))
          ),
          child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        )
      ],
    );
  }

  Widget __footerBtn() {
    return Positioned(
      bottom: 68,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 4),
          backgroundColor: Color(0xFFFF006C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: (){},
        child: Row(
          children: [
            Image.asset('assets/icons/Love.png', width: 40),
            SizedBox(width: 6),
            Text('Tap', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))
          ],
        )
      ),
    );
  }
}
