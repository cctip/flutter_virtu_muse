import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';

var formater = DateFormat('yyyy-MM-dd');

class DomainController extends GetxController {
  static final String _defaultUrl = 'assets/images/humans/MM_Astra.png';
  static final fliped = RxBool(false); // 是否翻牌
  static final flipTimesToday = RxInt(0); // 今日翻牌次数
  static final lastFlipTime = RxString(''); // 上次翻牌时间
  static final humanUrl = RxString(_defaultUrl); // 当前显示人物图片路径
  static final lockProgress = RxInt(0); // 解锁进度

  // 初始化
  static init() {
    initFlip();
    humanUrl.value = SharePref.getString('humanUrl') ?? _defaultUrl;
    lockProgress.value = SharePref.getInt('lockProgress') ?? 0;
  }

  static initFlip() {
    String today = formater.format(DateTime.now()); // 今天
    lastFlipTime.value = SharePref.getString('lastFlipTime') ?? '';
    if (lastFlipTime.value == today) {
    } else {
      SharePref.setBool('fliped', false);
      SharePref.setInt('flipTimesToday', 0);
    }
    fliped.value = SharePref.getBool('fliped') ?? false;
    flipTimesToday.value = SharePref.getInt('flipTimesToday') ?? 0;
  }

  // 增加解锁进度
  static increaseProgress() {
    if (lockProgress.value >= 100) return;
    lockProgress.value += 10;
    SharePref.setInt('lockProgress', lockProgress.value);
  }
  // 翻牌成功
  static flipSuccess() {
    fliped.value = true;
    SharePref.setBool('fliped', true);
    flipTimesToday.value += 1;
    SharePref.setInt('flipTimesToday', flipTimesToday.value);
    String today = formater.format(DateTime.now()); // 今天
    lastFlipTime.value = today;
    SharePref.setString('lastFlipTime', today);
  }
}