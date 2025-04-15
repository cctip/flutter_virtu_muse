import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/common.dart';
import '/controller/user.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 初始化后滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
    return CommonPage(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 72),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 48),
                      Expanded(child: Column(
                        children: [
                          __themeBox('Ethereal Dreams', 'ED', 100),
                          __themeBox('Battle Angels', 'BA', 80),
                          __themeBox('Street Vibes', 'SV', 60),
                          __themeBox('Royal Queens', 'RQ', 40),
                          __themeBox('Cyber Divas', 'CD', 20),
                          __themeBox('Mystic Muses', 'MM', 0),
                        ],
                      )),
                      SizedBox(width: 10)
                    ]
                  ),
                  Positioned(
                    child: Container(
                      width: 24,
                      height: 1104,
                      padding: EdgeInsets.only(bottom: 16),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 8,
                            height: 1104,
                            color: Color(0xFF232429),
                          ),
                          __levelPointer(),
                          __levelDot(level: 0),
                          __levelDot(level: 20),
                          __levelDot(level: 40),
                          __levelDot(level: 60),
                          __levelDot(level: 80),
                          __levelDot(level: 100),
                        ],
                      ),
                    )
                  )
                ],
              )
            )
          )
        ]
      )
    );
	}

  Widget __levelPointer() {
    return Positioned(
      bottom: UserController.level.value / 20 * 188 + 6,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Container(
              width: 8,
              height: UserController.level.value / 20 * 188,
              color: Color(0xFFFF006C),
            ),
          ),
          Container(
            width: 12,
            height: 12,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFF006C),
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          ),
          Positioned(
            top: 1,
            left: 24,
            child: Image.asset('assets/icons/pointer.png', width: 8)
          ),
          Positioned(
            top: -3,
            left: 30,
            child: Container(
              height: 18,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text('Lv.${UserController.level.value}', style: TextStyle(color: Color(0xFFFF006C), fontSize: 11))
            )
          ),
        ],
      )
    );
  }
  Widget __levelDot({required final int level}) {
    return Positioned(
      bottom: level / 20 * 188,
      child: Obx(() => Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: UserController.level.value >= level ? Color(0xFFFF006C) : Color(0xFF232429),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text('lv.$level', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600, overflow: TextOverflow.visible), softWrap: false),
      ))
    );
  }
  Widget __themeBox(title, image, int limit) {
    bool locked = UserController.level.value < limit;
    return Container(
      height: 168,
      margin: EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage('assets/images/themes/$image${locked ? '_locked' : ''}.png'), fit: BoxFit.cover)
      ),
      child: locked ? Container() : Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2, // 横向模糊强度
                sigmaY: 2, // 纵向模糊强度
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 38,
                alignment: Alignment.center,
                color: Color.fromRGBO(22, 22, 26, 0.72),
                child: Text('$title', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
          )
        ],
      )
    );
  }
}