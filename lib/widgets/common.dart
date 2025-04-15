import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '/controller/user.dart';
import '/controller/domain.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key, required this.child});
  final Widget child;

  @override
  State<CommonPage> createState() => CommonPageState();
}

class CommonPageState extends State<CommonPage> {
  // 加速器
  _showBooster() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              color: Color(0xFF16161A),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
            ),
            child: Column(
              children: [
                Image.asset('assets/icons/dialog_dot.png'),
                Image.asset('assets/icons/dialog_title.png', height: 124),
                SizedBox(height: 16),
                __boosterItem(icon: 'x2', text: 'Value x2 for 10 mins', love: 1),
                __boosterItem(icon: 'x3', text: 'Value x3 for 10 mins', love: 3),
                __boosterItem(icon: 'x4', text: 'Value x4 for 10 mins', love: 4),
                __boosterItem(icon: 'auto', text: 'Automatic click 30/s for 5 mins', love: 8),
                __boosterItem(icon: 'auto', text: 'Automatic click 100/s for 5 mins', love: 15),
              ],
            ),
          )
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    UserController.init();
    DomainController.init();
  }

  _formatCount(int count, int index) {
    final opt = ['k', 'm'];
    if (count <= 1000) {
      return count;
    }
    if (count / 1000 > 1000) {
      return _formatCount((count / 1000).round(), index + 1);
    }
    return '${count/1000}${opt[index]}';
  }

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
              padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: Column(
                children: [
                  __header(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 168,
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
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 60 - MediaQuery.of(context).padding.top,
            child: Opacity(opacity: 0.9, child: Image.asset('assets/images/humans/MM_Astra.png', fit: BoxFit.cover))
          ),
          Positioned(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10 - DomainController.lockProgress.value / 10, // 横向模糊强度
                  sigmaY: 10 - DomainController.lockProgress.value / 10, // 纵向模糊强度
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 60 - MediaQuery.of(context).padding.top,
                ),
              ),
            )
          )
        ],
      )
    );
  }

  // 顶部
  Widget __header() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
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
                      SizedBox(width: 2),
                      Obx(() => Text('${_formatCount(UserController.diamondTotal.value, 0)}', style: TextStyle(color: Colors.white, fontSize: 12)))
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
                Obx(() => Text('${UserController.love.value}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)))
              ],
            ),
          ),
        ),
        SizedBox(width: 24),
        GestureDetector(
          onTap: _showBooster,
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

  Widget __boosterItem({required final icon, required final text, required final love}) {
    return Container(
      height: 56,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Color(0xFF232429),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/rocket_$icon.png', width: 40),
          SizedBox(width: 8),
          Expanded(child: Text('$text', style: TextStyle(color: Colors.white))),
          SizedBox(
            width: 72,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                backgroundColor: Color(0xFFFF006C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/Love.png', width: 24),
                  Text('${love}k', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))
                ],
              )
            ),
          )
        ],
      ),
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