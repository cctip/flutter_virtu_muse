import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_virtu_muse/controller/booster.dart';
import 'package:get/state_manager.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card.dart';

import '/common/eventbus.dart';
import '/controller/user.dart';
import '/controller/domain.dart';
import '/widgets/common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<FlipCardState> cardKey_1 = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKey_2 = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKey_3 = GlobalKey<FlipCardState>();
  Timer? _timer;
  int _remainingTime = 180;
  bool _fliped = false; // 控制单次只能翻一张牌
  bool get _flipDisabled => DomainController.flipTimesToday > 1;
  bool get isCur => DomainController.readIndex.value == DomainController.switchIndex.value;
  bool get isLast => DomainController.readIndex.value == DomainController.switchList.length - 1;

  @override
  void initState() {
    super.initState();
    _startTimer();
    final throttler = Throttler(duration: Duration(seconds: 1));
    bus.on('autoClick', (_) => throttler.call(() {
      String accelerateType = BoosterController.accelerateType.value;
      int speed = accelerateType == 'auto30' ? 30 : 100;
      UserController.increaseLove(UserController.level.value * 5 * speed);
      _shakeAnimationController.start();
      _showAnimation();
    }));
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 开始倒计时
  void _startTimer() {
    if (_timer != null && _timer!.isActive || _flipDisabled) return;
    _remainingTime = DomainController.flipTimesToday.value == 1 ? 300 : 180;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTime();
    });
  }
  // 计算倒计时
  void _calculateTime() {
    setState(() {
      if (_remainingTime > 0) {
        _remainingTime--;
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });
  }
  String _formatDuration() {
    Duration d = Duration(seconds: _remainingTime);
    return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  // 小心心动画
  _showAnimation() {
    final offset = MediaQuery.of(context).size.width / 2 - Random().nextInt(40);
    Overlay.of(context).insert(OverlayEntry(builder: (context) => Positioned(
      bottom: 160 + MediaQuery.of(context).padding.bottom + 54,
      left: offset,
      child: FadeOutUp(child: Image.asset('assets/icons/Love.png', width: 40))
    )));
  }
  
  // 翻牌
  _onFlip() {
    showDialog(context: context, barrierDismissible: false, builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, child: __flipCard(cardKey_1)),
          Positioned(child: __flipCard(cardKey_2)),
          Positioned(right: 0, child: __flipCard(cardKey_3)),
          // Positioned(top: MediaQuery.of(context).size.height / 2 + 60, child: Text(_fliped ? '' : 'Choose a card to flip', style: TextStyle(color: Colors.white, fontSize: 16)))
        ]
      ),
    ));
  }
  Widget __flipCard(cardKey) {
    var _contentImage;
    int index = Random().nextInt(3); // 0-小心心 1-钻石 2-解锁进度+10
    int value = 0;
    switch(index) {
      case 0: _contentImage = 'assets/icons/Love.png'; value = 50 * ((DomainController.lockProgress.value / 10).round() + 1); break;
      case 1: _contentImage = 'assets/icons/dimond.png'; value = 5 * ((DomainController.lockProgress.value / 10).round() + 1); break;
      case 2: _contentImage = 'assets/images/humans/${DomainController.switchList[DomainController.switchIndex.value]}.png'; break;
    }
    return Obx(() => FlipCard(
      key: cardKey,
      flipOnTouch: false,
      // fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: GestureDetector(
        onTap: () {
          if (_fliped) return;
          setState(() => _fliped = true);
          cardKey.currentState.toggleCard();
          switch(index) {
            case 0: UserController.increaseLove(value); break;
            case 1: UserController.increaseDiamond(value); break;
            case 2: DomainController.increaseProgress(); break;
          }
        },
        child: Stack(
          children: [
            Image.asset('assets/icons/poker_back.png', height: 160),
          ],
        ),
      ),
      back: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/icons/poker_front.png', height: 220),
          Positioned(
            top: index == 2 ? 60: 70,
            child: index == 2 ? 
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(88)
                    ),
                    child: Image.asset(_contentImage, fit: BoxFit.cover)
                  ),
                  DomainController.lockProgress.value < 100 ? Positioned(
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2, // 横向模糊强度
                          sigmaY: 2, // 纵向模糊强度
                        ),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  ) : Container(),
                  Positioned(child: Container(
                    width: 100,
                    height: 33,
                    alignment: Alignment.center,
                    color: Color.fromRGBO(22, 22, 26, 0.72),
                    child: Obx(() => Text('Unlock: ${DomainController.lockProgress.value}%', style: TextStyle(color: Colors.white, fontSize: 16))),
                  ))
                ],
              ) :
              Column(children: [
                Image.asset(_contentImage, width: 56),
                Text('$value', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))
              ])
          ),
        ],
      ),
      onFlipDone: (_) async {
        DomainController.flipSuccess();
        await Future.delayed(Duration(seconds: 1));
        setState(() => _fliped = false);
        _startTimer();
        Navigator.pop(context);
      },
    ));
  }

  // 切换
  _onSwitch() {
    showDialog(context: context, useSafeArea: false, builder: (_) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 740,
          decoration: BoxDecoration(
            color: Color(0xFF16161A)
          ),
          child: Column(
            children: [
              Image.asset('assets/icons/dialog_dot.png'),
              Image.asset('assets/icons/title_switch.png', height: 124),
              Container(
                height: 360,
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DomainController.readIndex.value == 0 ? SizedBox(width: 32) : GestureDetector(
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFF232429),
                          borderRadius: BorderRadius.circular(32)
                        ),
                        child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 18),
                      ),
                      onTap: () {
                        DomainController.readPrev();
                      },
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 258,
                          height: 344,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFF232429),
                            border: Border.all(color: isCur ? Color(0xFFFF006C) : Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Container(
                            width: 258,
                            height: 344,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(image: __curImage(), fit: BoxFit.cover)
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ClipRRect(
                              clipBehavior: Clip.none,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10 - (isCur ? DomainController.lockProgress.value : 0) / 10, // 横向模糊强度
                                      sigmaY: 10 - (isCur ? DomainController.lockProgress.value : 0) / 10, // 纵向模糊强度
                                    ),
                                    child: Container(
                                      width: 258,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(22, 22, 26, 0.72),
                                      ),
                                      alignment: Alignment.center,
                                      child: __curName(),
                                    ),
                                  ),
                                ],
                              )
                            )
                          )
                        ),
                        isCur ? Positioned(top: 16, right: 16, child: Image.asset('assets/icons/choosed.png', width: 32)) : Container()
                      ],
                    ),
                    isLast ? SizedBox(width: 32) : GestureDetector(
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFF232429),
                          borderRadius: BorderRadius.circular(32)
                        ),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                      ),
                      onTap: () {
                        DomainController.readNext();
                      },
                    )
                  ],
                )),
              ),
              SizedBox(height: 16),
              Obx(() => __freeBtn()),
              SizedBox(height: 16),
              Obx(() => __feeBtn())
            ],
          ),
        )
      ]
    ));
  }
  AssetImage __curImage() {
    return AssetImage('assets/images/humans/${DomainController.switchList[DomainController.readIndex.value]}.png');
  }
  Widget __curName() {
    return Obx(() => Text(DomainController.nameList[DomainController.readIndex.value], style: TextStyle(color: Colors.white, fontSize: 16)));
  }
  Widget __freeBtn() {
    return SizedBox(
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
        onPressed: isCur || DomainController.freeSwitch.value ? null : DomainController.onSwitchFree,
        child: Text('Free Switch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
      ),
    );
  }
  Widget __feeBtn() {
    int fee = (DomainController.readIndex.value ~/ 5 + 1) * 1000;
    return SizedBox(
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
        onPressed: isCur || UserController.love.value < fee ? null : DomainController.onSwitchFee,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Switch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(width: 6),
            Image.asset('assets/icons/Love${isCur ? '_disabled' : ''}.png', width: 24),
            Text('$fee', style: TextStyle(fontWeight: FontWeight.w600))
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      child: Stack(
        alignment: Alignment.center,
        children: [
          __content(),
          Positioned(bottom: 100, child: __footerBtn())
        ],
      )
    );
  }

  // 操作功能
  Widget __content() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        __domainItem(
          icon: 'poker',
          text: _flipDisabled ? 'Fliped' : _remainingTime > 0 ? _formatDuration() : 'Flip',
          func: _flipDisabled || _remainingTime > 0 ? null : _onFlip
        ),
        Column(
          children: [
            __domainItem(icon: 'switch', text: 'Switch', func: _onSwitch),
            SizedBox(height: 16),
            __domainItem(icon: 'badge', text: 'Badge'),
          ],
        )
      ],
    );
  }
  Widget __domainItem({required String icon, required String text, func}) {
    bool disPoker = icon == 'poker' && (_flipDisabled || _remainingTime > 0);
    return GestureDetector(
      onTap: func,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 22, 26, 0.24),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
            ),
            child: Image.asset('assets/icons/$icon${disPoker ? '_disabled' : ''}.png'),
          ),
          Container(
            width: 64,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 22, 26, 0.4),
              border: Border(bottom: BorderSide(color: disPoker ? Color.fromRGBO(249, 249, 249, 0.8) : Color(0xFFFF006C)))
            ),
            child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
  
  ///抖动动画控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();
  ///构建抖动效果
  ShakeAnimationWidget __footerBtn() {
    return ShakeAnimationWidget(
      //抖动控制器
      shakeAnimationController: _shakeAnimationController,
      //微旋转的抖动
      shakeAnimationType: ShakeAnimationType.SkewShake,
      //设置不开启抖动
      isForward: false,
      //默认为 0 无限执行
      shakeCount: 1,
      //抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,
      //执行抖动动画的子Widget
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 4),
          backgroundColor: Color(0xFFFF006C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Row(
          children: [
            Image.asset('assets/icons/Love.png', width: 40),
            SizedBox(width: 6),
            Text('Tap', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))
          ],
        ),
        onPressed: () {
          String accelerateType = BoosterController.accelerateType.value;
          int speed = 1;
          if (BoosterController.accelerating.value) {
            if (accelerateType == 'auto30' || accelerateType == 'auto100') return;
            switch(accelerateType) {
              case 'x2': speed = 2; break;
              case 'x3': speed = 3; break;
              case 'x4': speed = 4; break;
            }
          }
          UserController.increaseLove(UserController.level.value * 5 * speed);
          _shakeAnimationController.start();
          _showAnimation();
        },
      )
    );
  }
}

class Throttler {
  final Duration _duration;
  Timer? _timer;
  bool _isThrottled = false;

  Throttler({required Duration duration}) : _duration = duration;

  void call(void Function() callback) {
    if (_isThrottled) return;
    
    _isThrottled = true;
    _timer?.cancel();
    
    callback(); // 执行传入的回调函数
    
    _timer = Timer(_duration, () {
      _isThrottled = false;
    });
  }
}