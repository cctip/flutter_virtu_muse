import 'package:flutter/material.dart';
import './home.dart';
import './spin.dart';
import './theme.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int currentIndex = 1;

  /// Tab 改变
  void onTabChanged(int index) {
    setState(() {
      if (currentIndex != index) {
        currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              SpinPage(),
              HomePage(),
              ThemePage(),
            ],
          ),
          __bottomBar(),
          __centerBtn()
        ],
      ),
    );
  }

  Widget __bottomBar() {
    return Container(
      height: 60 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        color: Color(0xFF232429),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 60,
              child: Image.asset('assets/images/tabbar/Spin${currentIndex == 0 ? '_ac' : ''}.png', width: 40, height: 44),
            ),
            onTapUp: (_) {
              onTabChanged(0);
            },
          ),
          InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 60,
              child: Image.asset('assets/images/tabbar/Theme${currentIndex == 2 ? '_ac' : ''}.png', width: 40, height: 44),
            ),
            onTapUp: (_) {
              onTabChanged(2);
            },
          ),
        ],
      )
    );
  }
  Widget __centerBtn() {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 - 36,
      bottom: MediaQuery.of(context).padding.bottom + 8,
      child: InkWell(
        child: Column(
          children: [
            Image.asset('assets/icons/Love.png', width: 72, height: 72),
            Text('Home', style: TextStyle(color: currentIndex == 1 ? Color(0xFFFF006C) : Color.fromRGBO(249, 249, 249, 0.8), fontWeight: FontWeight.w600)),
          ],
        ),
        onTapUp: (_) {
          onTabChanged(1);
        },
      ),
    );
  }
}
