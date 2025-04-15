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
  static final freeSpined = RxBool(false); // 免费抽奖已使用
  static final freeSpinTime = RxString(''); // 上次免费抽奖时间

  // 初始化
  static init() {
    avator.value = SharePref.getString('avator') ?? 'assets/images/avator.png';
    level.value = SharePref.getInt('level') ?? 1;
    diamond.value = SharePref.getInt('diamond') ?? 0;
    diamondTotal.value = SharePref.getInt('diamondTotal') ?? 0;
    love.value = SharePref.getInt('love') ?? 0;
    freeSpinTime.value = SharePref.getString('freeSpinTime') ?? '';
    if (freeSpinTime.value != '') {
      freeSpined.value = freeSpinTime.value == formater.format(DateTime.now());
    }
  }

  // 设置头像
  static setAvator(path) {
    avator.value = path;
    SharePref.setString('avator', path);
  }

  // 增加钻石
  static increaseDiamond(int value) {
    level.value += (diamond.value + value) ~/ 200;
    diamond.value = (diamond.value + value) % 200;
    diamondTotal.value += value;
    SharePref.setInt('level', level.value);
    SharePref.setInt('diamond', diamond.value);
    SharePref.setInt('diamondTotal', diamondTotal.value);
  }
  // 增加小心心
  static increaseLove(int value) {
    love.value += value;
    SharePref.setInt('love', love.value);
  }
  // 免费抽奖
  static onFreeSpin() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    freeSpined.value = true;
    SharePref.setString('freeSpinTime', today);
  }
}