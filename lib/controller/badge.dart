import 'package:flutter_virtu_muse/controller/booster.dart';
import 'package:flutter_virtu_muse/controller/domain.dart';
import 'package:flutter_virtu_muse/controller/user.dart';

import '/common/share_pref.dart';
import 'package:get/get.dart';

class BadgeController extends GetxController {
  static final List<String> badgeList = ['level_10', 'level_20', 'level_50', 'level_100', 'tap_10000', 'tap_50', 'spin_5', 'spin_15', 'spin_50', 'booster_1', 'booster_3', 'booster_10', 'coins_500k', 'coins_1m', 'nft_1', 'nft_3', 'nft_6', 'nft_9'];
  static final Map badgeInfo = {
    'level_10': 'Reach to level 10',
    'level_20': 'Reach to level 20 ',
    'level_50': 'Reach to level 50 ',
    'level_100': 'Reach to level 100 ',
    'tap_10000': 'Tap 10,000 times ',
    'tap_50': 'Tap 50 cards',
    'spin_5': 'Spin 5 times at the wheel',
    'spin_15': 'Spin 15 times at the wheel',
    'spin_50': 'Spin 50 times at the wheel',
    'nft_1': 'Collect 1 NFT avatar ',
    'nft_3': 'Collect 3 NFT avatar ',
    'nft_6': 'Collect 6 NFT avatar ',
    'nft_9': 'Collect 9 NFT avatar ',
    'coins_500k': 'Collect 500k coins ',
    'coins_1m': 'Collect 1m coins ',
    'booster_1': 'Redeem booster for 1 time',
    'booster_3': 'Redeem booster for 3 time',
    'booster_10': 'Redeem booster for 10 time',
  };
  static final Map badgeRewords = {
    'level_10': 10,
    'level_20': 100,
    'level_50': 200,
    'level_100': 500,
    'tap_10000': 30,
    'tap_50': 50,
    'spin_5': 15,
    'spin_15': 45,
    'spin_50': 90,
    'nft_1': 50,
    'nft_3': 100,
    'nft_6': 300,
    'nft_9': 600,
    'coins_500k': 80,
    'coins_1m': 900,
    'booster_1': 40,
    'booster_3': 85,
    'booster_10': 175,
  };
  static final Map badgeProgress = {
    'level_10': 0,
    'level_20': 0,
    'level_50': 0,
    'level_100': 0,
    'tap_10000': 0,
    'tap_50': 0,
    'spin_5': 0,
    'spin_15': 0,
    'spin_50': 0,
    'nft_1': 0,
    'nft_3': 0,
    'nft_6': 0,
    'nft_9': 0,
    'coins_500k': 0,
    'coins_1m': 0,
    'booster_1': 0,
    'booster_3': 0,
    'booster_10': 0,
  };
  static final Map badgeClaimed = {
    'level_10': false,
    'level_20': false,
    'level_50': false,
    'level_100': false,
    'tap_10000': false,
    'tap_50': false,
    'spin_5': false,
    'spin_15': false,
    'spin_50': false,
    'nft_1': false,
    'nft_3': false,
    'nft_6': false,
    'nft_9': false,
    'coins_500k': false,
    'coins_1m': false,
    'booster_1': false,
    'booster_3': false,
    'booster_10': false,
  }.obs;
  static final curBadgeIndex  = RxInt(0);

  // 初始化
  static init() {
    badgeClaimed['level_10'] = SharePref.getBool('claimed_level_10') ?? false;
    badgeClaimed['level_20'] = SharePref.getBool('claimed_level_20') ?? false;
    badgeClaimed['level_50'] = SharePref.getBool('claimed_level_50') ?? false;
    badgeClaimed['level_100'] = SharePref.getBool('claimed_level_100') ?? false;
    badgeClaimed['tap_10000'] = SharePref.getBool('claimed_tap_10000') ?? false;
    badgeClaimed['tap_50'] = SharePref.getBool('claimed_tap_50') ?? false;
    badgeClaimed['spin_5'] = SharePref.getBool('claimed_spin_5') ?? false;
    badgeClaimed['spin_15'] = SharePref.getBool('claimed_spin_15') ?? false;
    badgeClaimed['spin_50'] = SharePref.getBool('claimed_spin_50') ?? false;
    badgeClaimed['nft_1'] = SharePref.getBool('claimed_nft_1') ?? false;
    badgeClaimed['nft_3'] = SharePref.getBool('claimed_nft_3') ?? false;
    badgeClaimed['nft_6'] = SharePref.getBool('claimed_nft_6') ?? false;
    badgeClaimed['nft_9'] = SharePref.getBool('claimed_nft_9') ?? false;
    badgeClaimed['coins_500k'] = SharePref.getBool('claimed_coins_500k') ?? false;
    badgeClaimed['coins_1m'] = SharePref.getBool('claimed_coins_1m') ?? false;
    badgeClaimed['booster_1'] = SharePref.getBool('claimed_booster_1') ?? false;
    badgeClaimed['booster_3'] = SharePref.getBool('claimed_booster_3') ?? false;
    badgeClaimed['booster_10'] = SharePref.getBool('claimed_booster_10') ?? false;
  }

  // 初始化进度条
  static initProgress() {
    badgeProgress['level_10'] = UserController.level.value >= 10 ? 100 : UserController.level.value * 10;
    badgeProgress['level_20'] = UserController.level.value >= 20 ? 100 : UserController.level.value * 5;
    badgeProgress['level_50'] = UserController.level.value >= 50 ? 100 : UserController.level.value * 2;
    badgeProgress['level_100'] = UserController.level.value >= 100 ? 100 : UserController.level.value;
    badgeProgress['tap_10000'] = UserController.clickCountAll.value >= 10000 ? 100 : UserController.clickCountAll.value / 100;
    // badgeProgress['tap_50'] = ;
    badgeProgress['spin_5'] = UserController.spinTimes.value >= 5 ? 100 : UserController.spinTimes.value * 20;
    badgeProgress['spin_15'] = UserController.spinTimes.value >= 15 ? 100 : UserController.spinTimes.value * 100 / 15;
    badgeProgress['spin_50'] = UserController.spinTimes.value >= 50 ? 100 : UserController.spinTimes.value * 2;
    badgeProgress['nft_1'] = DomainController.unlockedList.isNotEmpty ? 100 : 0;
    badgeProgress['nft_3'] = DomainController.unlockedList.length >= 3 ? 100 : DomainController.unlockedList.length * 100 / 3;
    badgeProgress['nft_6'] = DomainController.unlockedList.length >= 3 ? 100 : DomainController.unlockedList.length * 100 / 6;
    badgeProgress['nft_9'] = DomainController.unlockedList.length >= 3 ? 100 : DomainController.unlockedList.length * 100 / 9;
    badgeProgress['coins_500k'] = UserController.loveTotal.value >= 500000 ? 100 : UserController.loveTotal.value * 100 / 500000;
    badgeProgress['coins_1m'] = UserController.loveTotal.value >= 1000000 ? 100 : UserController.loveTotal.value * 100 / 1000000;
    badgeProgress['booster_1'] = BoosterController.usedCount.value >= 1 ? 100 : 0;
    badgeProgress['booster_3'] = BoosterController.usedCount.value >= 3 ? 100 : BoosterController.usedCount.value * 100 / 3;
    badgeProgress['booster_10'] = BoosterController.usedCount.value >= 10 ? 100 : BoosterController.usedCount.value * 10;
  }

  static setIndex(index) {
    curBadgeIndex.value = index;
  }

  static onClaim() {
    String badge = badgeList[curBadgeIndex.value];
    int reword = badgeRewords[badge];
    UserController.increaseDiamond(reword);
    badgeClaimed[badge] = true;
    SharePref.setBool('claimed_$badge', true);
  }
}