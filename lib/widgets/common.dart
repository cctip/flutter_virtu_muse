import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '/common/eventbus.dart';

import '/controller/user.dart';
import '/controller/domain.dart';
import '/controller/booster.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key, required this.child});
  final Widget child;

  @override
  State<CommonPage> createState() => CommonPageState();
}

class CommonPageState extends State<CommonPage> {
  Timer? _timer;
  int _remainingTime = 0;
  
  @override
  void initState() {
    super.initState();
    UserController.init();
    DomainController.init();
    BoosterController.init();
    _startTimer();
    bus.on('startTimer', (_) => _startTimer());
  }

  // 开始倒计时
  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;
    String startTime = BoosterController.startTime.value;
    int sustainSeconds = BoosterController.sustainSeconds.value;
    Duration difference = DateTime.now().difference(DateTime.parse(startTime));
    int secondsDifference = difference.inSeconds;
    if (secondsDifference >= sustainSeconds) {
      _remainingTime = 0;
    } else {
      _remainingTime = sustainSeconds - secondsDifference;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateTime();
        String accelerateType = BoosterController.accelerateType.value;
        if (accelerateType == 'auto30' || accelerateType == 'auto100') {
          bus.emit('autoClick');
        }
      });
    }
  }
  // 计算倒计时
  void _calculateTime() {
    setState(() {
      if (_remainingTime > 0) {
        _remainingTime--;
      } else {
        BoosterController.initAccelerate();
        _timer?.cancel();
        _timer = null;
      }
    });
  }
  String _formatDuration() {
    Duration d = Duration(seconds: _remainingTime);
    return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

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
            child: Obx(() => Column(
              children: [
                Image.asset('assets/icons/dialog_dot.png'),
                Image.asset('assets/icons/dialog_title.png', height: 124),
                SizedBox(height: 16),
                __boosterItem(icon: 'x2', type: 'x2', text: 'Value x2 for 10 mins', love: 1, count: BoosterController.boosterCount2.value, func: () {
                  if (BoosterController.boosterCount2.value > 0) {
                    BoosterController.useBooster2();
                  } else if (UserController.love >= 1000) {
                    UserController.decreaseLove(1000);
                    BoosterController.increaseBooster2();
                  }
                }),
                __boosterItem(icon: 'x3', type: 'x3', text: 'Value x3 for 10 mins', love: 3, count: BoosterController.boosterCount3.value, func: () {
                  if (BoosterController.boosterCount3.value > 0) {
                    BoosterController.useBooster3();
                  } else if (UserController.love >= 3000) {
                    UserController.decreaseLove(3000);
                    BoosterController.increaseBooster3();
                  }
                }),
                __boosterItem(icon: 'x4', type: 'x4', text: 'Value x4 for 10 mins', love: 4, count: BoosterController.boosterCount4.value, func: () {
                  if (BoosterController.boosterCount4.value > 0) {
                    BoosterController.useBooster4();
                  } else if (UserController.love >= 4000) {
                    UserController.decreaseLove(4000);
                    BoosterController.increaseBooster4();
                  }
                }),
                __boosterItem(icon: 'auto', type: 'auto30', text: 'Automatic click 30/s for 5 mins', love: 8, count: BoosterController.boosterCount30.value, func: () {
                  if (BoosterController.boosterCount30.value > 0) {
                    BoosterController.useBooster30();
                  } else if (UserController.love >= 8000) {
                    UserController.decreaseLove(8000);
                    BoosterController.increaseBooster30();
                  }
                }),
                __boosterItem(icon: 'auto', type: 'auto100', text: 'Automatic click 100/s for 5 mins', love: 15, count: BoosterController.boosterCount100.value, func: () {
                  if (BoosterController.boosterCount100.value > 0) {
                    BoosterController.useBooster100();
                  } else if (UserController.love >= 150000) {
                    UserController.decreaseLove(15000);
                    BoosterController.increaseBooster100();
                  }
                }),
              ],
            )),
          )
        ],
      )
    );
  }

  // 格式化数字
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
    return Obx(() => Positioned(
      top: 0,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 60 - MediaQuery.of(context).padding.top,
            child: Opacity(opacity: 0.9, child: Image.asset('assets/images/humans/${DomainController.switchList[DomainController.switchIndex.value]}.png', fit: BoxFit.cover))
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
    ));
  }

  // 顶部
  Widget __header() {
    return Row(
      children: [
        GestureDetector(
          child: Stack(
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
                  child: Image.asset(UserController.avator.value, fit: BoxFit.cover),
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
          onTap: () {
            Get.toNamed('/profile');
          },
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
                Obx(() => Text('${_formatCount(UserController.love.value, 0)}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)))
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Obx(() => Image.asset(BoosterController.boosterUrl.value, width: 32)),
                Obx(() => BoosterController.accelerating.value ? Positioned(bottom: -14, child: Text(_formatDuration(), style: TextStyle(color: Colors.white, fontSize: 10))) : Container())
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget __boosterItem({required final icon, required final text, required final love, required final int count, final type, final func}) {
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/icons/rocket_$icon.png', width: 40),
              count > 0 ? Positioned(
                left: -2,
                child: Container(
                  height: 14,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text('$count', style: TextStyle(color: Colors.white, fontSize: 12, height: 0.8)),
                )
              ) : Container()
            ],
          ),
          SizedBox(width: 8),
          Expanded(child: Text('$text', style: TextStyle(color: Colors.white))),
          BoosterController.accelerating.value ?
            BoosterController.accelerateType.value == type ?
              Text('Accelerating', style: TextStyle(color: Color(0xFFFF006C), fontWeight: FontWeight.w600)) :
              Container()
            : SizedBox(
            width: 72,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                backgroundColor: Color(0xFFFF006C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: () => func(),
              child: count > 0 ? Text('Use', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)) : Row(
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