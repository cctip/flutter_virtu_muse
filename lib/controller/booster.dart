import 'package:flutter_virtu_muse/common/eventbus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';

var formater = DateFormat('yyyy-MM-dd HH:mm:ss');

class BoosterController extends GetxController {
  static final String _defaultUrl = 'assets/icons/rocket.png';
  static final String _booster2Url = 'assets/icons/rocket_x2.png';
  static final String _booster3Url = 'assets/icons/rocket_x3.png';
  static final String _booster4Url = 'assets/icons/rocket_x4.png';
  static final String _boosterAutoUrl = 'assets/icons/rocket_auto.png';
  static final boosterCount2 = RxInt(0); // x2加速器数量
  static final boosterCount3 = RxInt(0); // x3加速器数量
  static final boosterCount4 = RxInt(0); // x4加速器数量
  static final boosterCount30 = RxInt(0); // x30自动加速器数量
  static final boosterCount100 = RxInt(0); // x100自动加速器数量
  static final boosterUrl = RxString(_defaultUrl); // 当前显示加速器图片路径
  static final accelerating = RxBool(false); // 正在加速中
  static final accelerateType = RxString(''); // 正在加速中的加速器类型
  static final startTime = RxString(''); // 开始加速时间
  static final sustainSeconds = RxInt(0); // 加速持续时间-单位s
  static final usedCount = RxInt(0); // 使用次数

  // 初始化
  static init() {
    boosterCount2.value = SharePref.getInt('boosterCount2') ?? 0;
    boosterCount3.value = SharePref.getInt('boosterCount3') ?? 0;
    boosterCount4.value = SharePref.getInt('boosterCount4') ?? 0;
    boosterCount30.value = SharePref.getInt('boosterCount30') ?? 0;
    boosterCount100.value = SharePref.getInt('boosterCount100') ?? 0;
    accelerateType.value = SharePref.getString('accelerateType') ?? '';
    initAccelerate();
  }

  // 初始化加速状态
  static initAccelerate() {
    usedCount.value = SharePref.getInt('SharePref') ?? 0;
    startTime.value = SharePref.getString('startTime') ?? '';
    sustainSeconds.value = SharePref.getInt('sustainSeconds') ?? 0;
    if (startTime.value == '') return;
    Duration difference = DateTime.now().difference(formater.parse(startTime.value));
    int secondsDifference = difference.inSeconds;
    if (secondsDifference >= sustainSeconds.value) {
      accelerating.value = false;
      boosterUrl.value = _defaultUrl;
    } else {
      accelerating.value = true;
      accelerateType.value = SharePref.getString('accelerateType');
      switch(accelerateType.value) {
        case 'x2': boosterUrl.value = _booster2Url; break;
        case 'x3': boosterUrl.value = _booster3Url; break;
        case 'x4': boosterUrl.value = _booster4Url; break;
        case 'auto30': boosterUrl.value = _boosterAutoUrl; break;
        case 'auto100': boosterUrl.value = _boosterAutoUrl; break;
      }
      bus.emit('startTimer');
    }
  }

  // 增加加速器数量
  static increaseBooster2() {
    boosterCount2.value += 1;
    SharePref.setInt('boosterCount2', boosterCount2.value);
  }
  static increaseBooster3() {
    boosterCount3.value += 1;
    SharePref.setInt('boosterCount3', boosterCount3.value);
  }
  static increaseBooster4() {
    boosterCount4.value += 1;
    SharePref.setInt('boosterCount4', boosterCount4.value);
  }
  static increaseBooster30() {
    boosterCount30.value += 1;
    SharePref.setInt('boosterCount30', boosterCount30.value);
  }
  static increaseBooster100() {
    boosterCount100.value += 1;
    SharePref.setInt('boosterCount100', boosterCount100.value);
  }

  // 使用加速器
  static useBooster2() {
    boosterCount2.value -= 1;
    SharePref.setInt('boosterCount2', boosterCount2.value);
    startAccelerate('x2', 600);
  }
  static useBooster3() {
    boosterCount3.value -= 1;
    SharePref.setInt('boosterCount3', boosterCount3.value);
    startAccelerate('x3', 600);
  }
  static useBooster4() {
    boosterCount4.value -= 1;
    SharePref.setInt('boosterCount4', boosterCount4.value);
    startAccelerate('x4', 600);
  }
  static useBooster30() {
    boosterCount30.value -= 1;
    SharePref.setInt('boosterCount30', boosterCount30.value);
    startAccelerate('auto30', 300);
  }
  static useBooster100() {
    boosterCount100.value -= 1;
    SharePref.setInt('boosterCount100', boosterCount100.value);
    startAccelerate('auto100', 300);
  }

  // 开始加速
  static startAccelerate(type, seconds) {
    usedCount.value++;
    SharePref.setInt('usedCount', usedCount.value);
    accelerateType.value = type;
    SharePref.setString('accelerateType', accelerateType.value);
    accelerating.value = true;
    String now = formater.format(DateTime.now());
    startTime.value = now;
    SharePref.setString('startTime', startTime.value);
    sustainSeconds.value = seconds;
    SharePref.setInt('sustainSeconds', sustainSeconds.value);

    initAccelerate();
  }
}