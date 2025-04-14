import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            __bgImage(),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  __header(),
                  SizedBox(height: 20),
                  __content(),
                ],
              ),
            ),
            __footerBtn()
          ],
        ),
      )
    );
  }

  Widget __bgImage() {
    return Positioned(
      child: Container(
        child: Image.asset('assets/images/humans/MM_Astra.png'),
      )
    );
  }

  Widget __header() {
    return Row(
      children: [
        GestureDetector(
          child: Image.asset('assets/images/avator.png', width: 56),
        ),
        SizedBox(width: 24),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 22, 26, 0.72),
              borderRadius: BorderRadius.circular(24)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/Love.png', width: 32),
                SizedBox(width: 8),
                Text('0', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ),
        SizedBox(width: 24),
        GestureDetector(
          child: Container(
            width: 56,
            height: 56,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 22, 26, 0.72),
              borderRadius: BorderRadius.circular(16)
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset('assets/icons/rocket.png', width: 32),
          ),
        ),
      ],
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
      bottom: MediaQuery.of(context).padding.bottom + 160,
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
