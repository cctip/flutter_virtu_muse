import 'dart:math';

import 'package:flutter/material.dart';
import '/controller/booster.dart';
import '/controller/user.dart';
import '/widgets/rotate_wheel.dart';
import '/widgets/common.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({super.key});
  @override
  State<SpinPage> createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool spining = false;
  List rewordType = ['love', 'dimond', 'kt', 'booster'];
  List rewordValue = [800, 10, 0, 'auto', 100, 300, 0, 'x2', 200, 100, 0, 'x3', 400, 50, 0, 'x4'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 开始抽奖
  _onSpin() async {
    if (spining) return;
    setState(() => spining = true);
    _controller.repeat();
    int seconds = Random().nextInt(3) + 1;
    await Future.delayed(Duration(seconds: seconds));
    _controller.stop();
    setState(() => spining = false);
    
    // 将弧度转换为角度（0-360）
    double degrees = (_controller.value * 360) % 360 - 11.25;
    if (degrees < 0) degrees += 360; // 处理负角度
    final double sectorAngle = 360 / 16; // 每份角度大小
    int index = 15 - (degrees / sectorAngle).floor(); // 计算落点索引（顺时针排列）
    String type = rewordType[index % 4];
    var value = rewordValue[index];
    late String rewordImage;
    switch(type) {
      case 'love': rewordImage = 'assets/icons/Love.png'; break;
      case 'dimond': rewordImage = 'assets/icons/dimond.png'; break;
      case 'booster': rewordImage = 'assets/icons/rocket_$value.png'; value = 'x1'; break;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 370,
            height: type == 'kt' ? 260 : 328,
            decoration: BoxDecoration(
              color: Color(0xFF16161A),
              borderRadius: BorderRadius.circular(24)
            ),
            child: Stack(
              children: [
                Positioned(child: Image.asset('assets/images/spin/${type == 'kt' ? 'keep_trying' : 'reword_bg'}.png', width: 370)),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset('assets/images/spin/${type == 'kt' ? 'so_close' : 'awesome'}.png', height: 28),
                    SizedBox(height: type == 'kt' ? 0 : 44),
                    type == 'kt' ? Container() : Image.asset(rewordImage, width: 64),
                    type == 'kt' ? Container() : SizedBox(height: 6),
                    type == 'kt' ? Container() : Text('Reword:', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                    type == 'kt' ? Container() : Text('$value', style: TextStyle(color: Color(0xFFFF006C), fontSize: 18)),
                    Spacer(),
                    SizedBox(
                      width: 242,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFFF006C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        onPressed: () {
                          if (type == 'love') {
                            UserController.increaseLove(value);
                          } else if (type == 'dimond') {
                            UserController.increaseDiamond(value);
                          } else if (type == 'booster') {
                            switch(rewordValue[index]) {
                              case 'x2': BoosterController.increaseBooster2(); break;
                              case 'x3': BoosterController.increaseBooster3(); break;
                              case 'x4': BoosterController.increaseBooster4(); break;
                              case 'auto': BoosterController.increaseBooster30(); break;
                            }
                          }
                          UserController.onSpinSuccess();
                          Navigator.pop(context);
                        },
                        child: Text('Claim', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            )
          )
        ],
      )
    );
  }

	@override
	Widget build(BuildContext context) {
    return CommonPage(
      child: Column(
        children: [
          SizedBox(height: 8),
          Image.asset('assets/images/spin/title.png', height: 24),
          SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/spin/spin_base.png', width: 370),
              RotatingWheel(
                image: Image.asset('assets/images/spin/spin_panel.png', width: 284), // 替换为你的图片地址
                controller: _controller,
              ),
              RotatingWheel(
                image: Image.asset('assets/images/spin/spin_rewards.png', width: 242), // 替换为你的图片地址
                controller: _controller,
              ),
              Positioned(top: 8, child: Image.asset('assets/images/spin/spin_finger.png', width: 32)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 32),
                SizedBox(
                  width: 242,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.8),
                      backgroundColor: Color(0xFFFF006C),
                      disabledBackgroundColor: Color(0xFF35363C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: UserController.freeSpined.value ? null : () {
                      UserController.onFreeSpin();
                      _onSpin();
                    },
                    child: Text('Free Spin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 242,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.8),
                      backgroundColor: Color(0xFFFFAA00),
                      disabledBackgroundColor: Color(0xFF35363C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: UserController.love.value >= 500 ? () {
                      UserController.decreaseLove(500);
                      _onSpin();
                    } : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Spin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(width: 6),
                        Image.asset('assets/icons/Love${UserController.love.value >= 500 ? '' : '_disabled'}.png', width: 24),
                        Text('500', style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    )
                  ),
                )
              ],
            )
          )
        ],
      )
    );
	}
}