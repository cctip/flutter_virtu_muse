import 'package:flutter/material.dart';
import 'dart:ui';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key, required this.child});
  final Widget child;

  @override
  State<CommonPage> createState() => CommonPageState();
}

class CommonPageState extends State<CommonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            __bgImage(),

            __shadowTop(),
            __shadowBottom(),
            __shadowLeft(),
            __shadowRight(),

            Container(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
              child: Column(
                children: [
                  __header(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 186,
                    child: widget.child,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 背景
  Widget __bgImage() {
    return Positioned(
      top: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 60 - MediaQuery.of(context).padding.top,
        child: Opacity(opacity: 0.8, child: Image.asset('assets/images/humans/MM_Astra.png', fit: BoxFit.cover)),
      )
    );
  }

  // 顶部
  Widget __header() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(56)
              ),
              child: ClipOval(
                child: Image.asset('assets/images/avator.png', fit: BoxFit.cover),
              )
            ),
            Positioned(
              bottom: 1,
              child: Container(
                width: 48,
                height: 18,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 26, 0.72),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2.0, // 横向模糊强度
                      sigmaY: 2.0, // 纵向模糊强度
                    ),
                    child: Container(
                      width: 48,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              )
            ),
            Positioned(
              left: 0,
              bottom: -1,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/dimond.png', width: 22, height: 22),
                      SizedBox(width: 8),
                      Text('0', style: TextStyle(color: Colors.white, fontSize: 12))
                    ],
                  )
                ],
              )
            )
          ],
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

  // 页面阴影
  Widget __shadowTop() {
    return Positioned(
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            stops: [0, 1], // 调整渐变范围
          ),
        ),
      )
    );
  }
  Widget __shadowBottom() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 60,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            stops: [0, 1], // 调整渐变范围
          ),
        ),
      )
    );
  }
  Widget __shadowLeft() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: 50,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black38,
              Colors.transparent,
            ],
            stops: [0, 1], // 调整渐变范围
          ),
        ),
      )
    );
  }
  Widget __shadowRight() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 50,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.black38,
              Colors.transparent,
            ],
            stops: [0, 1], // 调整渐变范围
          ),
        ),
      )
    );
  }
}