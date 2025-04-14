import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final avator = 'assets/images/avator/1.png'.obs;
  static final level = RxInt(1);
  static final diamond = RxInt(0);
  static final diamondTotal = RxInt(0);
  static final freeSpined = RxBool(false); // 免费抽奖已使用
  static final freeSpinTime = RxString(''); // 上次免费抽奖时间

  // 初始化
  static init() {
    validAvator();
    level.value = SharePref.getInt('level') ?? 1;
    diamond.value = SharePref.getInt('diamond') ?? 0;
    diamondTotal.value = SharePref.getInt('diamondTotal') ?? 0;
    freeSpinTime.value = SharePref.getString('freeSpinTime') ?? '';
    if (freeSpinTime.value != '') {
      freeSpined.value = freeSpinTime.value == formater.format(DateTime.now());
    }
  }

  // 验证头像是否存在
  static validAvator() {
    String path = SharePref.getString('avator') ?? '';
    if (path == '') return;
    avator.value = path;
    
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
  // 免费抽奖
  static onFreeSpin() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    freeSpined.value = true;
    SharePref.setString('freeSpinTime', today);
  }
}