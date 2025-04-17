import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '/controller/user.dart';
import 'package:get/get.dart';
import '/controller/domain.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  List<String> get _collectionList => DomainController.unlockedList;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Color(0xff000000),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: false,
            title: Text('Profile', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Image.asset('assets/icons/settings.png', width: 24),
                      onTap: () {
                        Get.toNamed('/setting');
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                __bgImage(),

                __shadowTop(),
                __shadowBottom(),
                __shadowLeft(),
                __shadowRight(),

                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          __userCard(),
                          __data(),
                          __collections(),
                          SizedBox(height: MediaQuery.of(context).padding.bottom)
                        ],
                      )
                    )
                  ],
                )
              ],
            )
          )
        ],
      )
    );
	}

  // 用户信息
  Widget __userCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 144,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF16161A),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Row(
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
                    child: Obx(() => Image.asset(UserController.avator.value, fit: BoxFit.cover)),
                  )
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 266,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text('Lv.${UserController.level.value}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
                          Row(
                            children: [
                              Image.asset('assets/icons/dimond.png', width: 16),
                              SizedBox(width: 4),
                              Obx(() => Text('${UserController.diamond.value}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                              SizedBox(width: 4),
                              Text('/200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontWeight: FontWeight.w400)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 6),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            width: 266,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(0xFF232429),
                              borderRadius: BorderRadius.circular(16)
                            ),
                          ),
                          Positioned(child: Container(
                            width: 266 / 200 * UserController.diamond.value,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF006C),
                              borderRadius: BorderRadius.circular(16)
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/icons/love_progress.png'))
              ),
              child: Row(
                children: [
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Love.png', width: 24),
                      SizedBox(width: 4),
                      Text('${UserController.level.value * 5}/click', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                    ],
                  )),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Love.png', width: 24),
                      SizedBox(width: 4),
                      Text('${(UserController.level.value + 1) * 5}/click', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  // Data
  Widget __data() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text('Data', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 177,
                height: 84,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 26, 0.72),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('All clicks', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8))),
                    Text('${UserController.clickCountAll.value}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                width: 177,
                height: 84,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 26, 0.72),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('All coins', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8))),
                    Text('${_formatCount(UserController.loveTotal.value, 0)}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 177,
                height: 84,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 26, 0.72),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Today clicks', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8))),
                    Text('${UserController.clickCountToday.value}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                width: 177,
                height: 84,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 26, 0.72),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Today coins', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8))),
                    Text('${_formatCount(UserController.loveToday.value, 0)}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Collections
  Widget __collections() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('Collections', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Container(
            width: MediaQuery.of(context).size.width,
            height: _collectionList.length > 2 ? 500 : 257,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 22, 26, 0.72),
              borderRadius: BorderRadius.circular(8)
            ),
            child: _collectionList.isEmpty ? Text('No Data', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)) : MasonryGridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 2, //几列
              mainAxisSpacing: 16, // 间距
              crossAxisSpacing: 16, // 纵向间距？
              itemCount: _collectionList.length, // 元素个数
              itemBuilder: (context, index) {
                return Container(
                  width: 169,
                  height: 225,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage('assets/images/humans/${_collectionList[index]}.png'), fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4, // 横向模糊强度
                            sigmaY: 4, // 纵向模糊强度
                          ),
                          child: Container(
                            height: 38,
                            alignment: Alignment.center,
                            color: Color.fromRGBO(22, 22, 26, 0.72),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 83,
                                  height: 22,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xFFFF006C),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {
                                      UserController.setAvator(index);
                                    },
                                    child: Text('Set as avator', style: TextStyle(fontSize: 12))
                                  ),
                                ),
                                // SizedBox(
                                //   width: 71,
                                //   height: 22,
                                //   child: ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //       padding: EdgeInsets.all(0),
                                //       foregroundColor: Colors.white,
                                //       backgroundColor: Color(0xFFFFAA00),
                                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                //     ),
                                //     onPressed: () {},
                                //     child: Text('Download', style: TextStyle(fontSize: 12))
                                //   ),
                                // )
                              ],
                            )
                          ),
                        ),
                      )
                    ],
                  )
                );
              }
            ),
          )
        ],
      ),
    );
  }

  // 背景
  Widget __bgImage() {
    return Positioned(
      top: 0,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 60 - MediaQuery.of(context).padding.top,
            child: Opacity(opacity: 0.9, child: Image.asset('assets/images/humans/MM_Astra.png', fit: BoxFit.cover))
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
      bottom: MediaQuery.of(context).padding.bottom,
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