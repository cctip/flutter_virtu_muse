// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

import 'package:flutter_virtu_muse/controller/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';

var formater = DateFormat('yyyy-MM-dd');

class DomainController extends GetxController {
  static final List<String> theme_MM = ['MM_Nova', 'MM_Lyra', 'MM_Astra', 'MM_Elara', 'MM_Echo'];
  static final List<String> theme_CD = ['CD_Aria', 'CD_Circuit', 'CD_Pixel', 'CD_Vortex', 'CD_Zyra'];
  static final List<String> theme_RQ = ['RQ_Celestia', 'RQ_Noctis', 'RQ_Aurelia', 'RQ_Valleria', 'RQ_Elara'];
  static final List<String> theme_SV = ['SV_Seraph', 'SV_Nyx', 'SV_Nina', 'SV_Roxy', 'SV_Kaiya'];
  static final List<String> theme_BA = ['BA_Valeria', 'BA_Seraph', 'BA_Blaze', 'BA_Cassia', 'BA_Valkyrie'];
  static final List<String> theme_ED = ['ED_Aurelia', 'ED_Zariah', 'ED_Nyxian', 'ED_Luminara', 'ED_Solara'];
  static final List<String> nameList = [
    '#101   Nova',
    '#102   Lyra',
    '#103   Astra',
    '#104   Elara',
    '#105   Echo',
    '#201   Aria',
    '#202   Circuit',
    '#203   Pixel',
    '#204   Vortex',
    '#205   Zyra',
    '#301   Celestia',
    '#302   Noctis',
    '#303   Aurelia',
    '#304   Valleria',
    '#305   Elara',
    '#401   Seraph',
    '#402   Nyx',
    '#403   Nina',
    '#404   Roxy',
    '#405   Kaiya',
    '#501   Valeria',
    '#502   Seraph',
    '#503   Blaze',
    '#504   Cassia',
    '#505   Valkyrie',
    '#601   Aurelia',
    '#602   Zariah',
    '#603   Nyxian',
    '#604   Luminara',
    '#605   Solara',
  ];

  static final unlockedList = RxList<String>([]); // 已解锁

  static final fliped = RxBool(false); // 是否翻牌
  static final flipTimesToday = RxInt(0); // 今日翻牌次数
  static final lastFlipTime = RxString(''); // 上次翻牌时间
  static final lockProgress = RxInt(0); // 解锁进度
  static final switchList = RxList<String>(); // 所有可切换列表
  static final switchIndex = RxInt(0); // 当前选中下标
  static final readIndex = RxInt(0); // 当前阅读下标
  static final freeSwitch = RxBool(false); // 是否免费切换
  static final freeSwitchTime = RxString(''); // 免费切换时间

  // 初始化
  static init() {
    initFlip();
    initSwitch();
    lockProgress.value = SharePref.getInt('lockProgress') ?? 0;
    switchIndex.value = SharePref.getInt('switchIndex') ?? 0;
    readIndex.value = switchIndex.value;
    freeSwitchTime.value = SharePref.getString('freeSwitchTime') ?? '';
    if (freeSwitchTime.value != '') {
      freeSwitch.value = freeSwitchTime.value == formater.format(DateTime.now());
    }
    unlockedList.value = SharePref.getStringList('unlockedList') ?? [];
  }

  // 初始化翻牌
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
  // 初始化切换
  static initSwitch() {
    switchList.value.clear();
    switchList.value.addAll(theme_MM);
    final int level = UserController.level.value;
    if (level >= 20) {
      switchList.value.addAll(theme_CD);
    }
    if (level >= 40) {
      switchList.value.addAll(theme_RQ);
    }
    if (level >= 60) {
      switchList.value.addAll(theme_SV);
    }
    if (level >= 80) {
      switchList.value.addAll(theme_BA);
    }
    if (level >= 100) {
      switchList.value.addAll(theme_ED);
    }
  }

  // 增加解锁进度
  static increaseProgress() {
    if (lockProgress.value >= 100) return;
    lockProgress.value += 10;
    SharePref.setInt('lockProgress', lockProgress.value);
    if (lockProgress.value == 100) {
      String curHuman = switchList[switchIndex.value];
      unlockedList.value.add(curHuman);
      SharePref.setStringList('unlockedList', unlockedList.value);
    }
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

  // 下一张
  static readNext() {
    if (readIndex.value < switchList.length - 1) {
      readIndex.value += 1;
    }
  }
  // 上一张
  static readPrev() {
    if (readIndex.value > 0) {
      readIndex.value -= 1;
    }
  }

  // 免费切换
  static onSwitchFree() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    freeSwitch.value = true;
    SharePref.setString('freeSwitchTime', today);
    startSwitch();
  }
  // 付费切换
  static onSwitchFee() {
    UserController.decreaseLove((readIndex.value ~/ 5 + 1) * 1000);
    startSwitch();
  }
  // 开始切换
  static startSwitch() {
    switchIndex.value = readIndex.value;
    SharePref.setInt('switchIndex', switchIndex.value);
    lockProgress.value = 0;
    SharePref.setInt('lockProgress', lockProgress.value);
  }
}