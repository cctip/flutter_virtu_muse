import '/controller/domain.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final avator = 'assets/images/avator.png'.obs;
  static final level = RxInt(30);
  static final diamond = RxInt(0);
  static final diamondTotal = RxInt(0);
  static final love = RxInt(0);
  static final loveTotal = RxInt(0);
  static final loveToday = RxInt(0);
  static final loveTime = RxString('');
  static final clickCountAll = RxInt(0);
  static final clickCountToday = RxInt(0);
  static final clickTime = RxString('');
  static final freeSpined = RxBool(false); // 免费抽奖已使用
  static final freeSpinTime = RxString(''); // 上次免费抽奖时间
  static final spinTimes = RxInt(0);

  // 初始化
  static init() {
    String today = formater.format(DateTime.now());
    avator.value = SharePref.getString('avator') ?? 'assets/images/avator.png';
    level.value = SharePref.getInt('level') ?? 1;
    diamond.value = SharePref.getInt('diamond') ?? 0;
    diamondTotal.value = SharePref.getInt('diamondTotal') ?? 0;

    love.value = SharePref.getInt('love') ?? 0;
    loveTotal.value = SharePref.getInt('loveTotal') ?? 0;
    loveTime.value = SharePref.getString('loveTime') ?? '';
    loveToday.value = loveTime.value == today ? SharePref.getInt('loveToday') : 0;
    
    clickCountAll.value = SharePref.getInt('clickCountAll') ?? 0;
    clickTime.value = SharePref.getString('clickTime') ?? '';
    clickCountToday.value = clickTime.value == today ? SharePref.getInt('clickCountToday') : 0;
    
    freeSpinTime.value = SharePref.getString('freeSpinTime') ?? '';
    freeSpined.value = freeSpinTime.value == today;
    spinTimes.value = SharePref.getInt('spinTimes') ?? 0;
  }

  // 设置头像
  static setAvator(index) {
    avator.value = 'assets/images/humans/${DomainController.unlockedList[index]}.png';
    SharePref.setString('avator', avator.value);
  }

  // 点击小心心
  static onClickLove() {
    clickCountAll.value++;
    SharePref.setInt('clickCountAll', clickCountAll.value);

    String today = formater.format(DateTime.now());
    if (clickTime.value == today) {
      clickCountToday.value++;
    } else {
      clickCountToday.value = 1;
      clickTime.value = today;
      SharePref.setString('clickTime', today);
    }
    SharePref.setInt('clickCountToday', clickCountToday.value);
  }

  // 增加钻石
  static increaseDiamond(int value) {
    level.value += (diamond.value + value) ~/ 200;
    diamond.value = (diamond.value + value) % 200;
    diamondTotal.value += value;
    SharePref.setInt('level', level.value);
    SharePref.setInt('diamond', diamond.value);
    SharePref.setInt('diamondTotal', diamondTotal.value);
    DomainController.initSwitch();
  }
  // 增加小心心
  static increaseLove(int value) {
    love.value += value;
    loveTotal.value += value;
    SharePref.setInt('love', love.value);
    SharePref.setInt('loveTotal', love.value);

    String today = formater.format(DateTime.now());
    if (loveTime.value == today) {
      loveToday.value += value;
    } else {
      loveToday.value = value;
      loveTime.value = today;
      SharePref.setString('loveTime', today);
    }
    SharePref.setInt('loveToday', loveToday.value);
  }
  // 减少小心心
  static decreaseLove(int value) {
    love.value -= value;
    SharePref.setInt('love', love.value);
  }
  // 免费抽奖
  static onFreeSpin() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    freeSpined.value = true;
    SharePref.setString('freeSpinTime', today);
  }
  // 抽奖成功
  static onSpinSuccess() {
    spinTimes.value++;
    SharePref.setInt('spinTimes', spinTimes.value);
  }
}