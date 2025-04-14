import 'package:flutter/material.dart';

class Utils {
  static void toast(BuildContext context, { required message }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(message, style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.w700
            ))
          ],
        ),
      )
    );
  }

  static void showRewardDialog(BuildContext context, { points, exp }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 390,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
            ),
            child: Column(
              children: [
                Image.asset('assets/images/home/reward_title.png'),
                SizedBox(height: 44),
                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 110,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F3F4),
                    borderRadius: BorderRadius.circular(32)
                  ),
                  child: Column(
                    children: [
                      Text('Claim your reward based on the prediction result!', style: TextStyle(height: 1)),
                      Spacer(),
                      Row(
                        children: [
                          points != null ? Expanded(child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/star.png', width: 32),
                                SizedBox(width: 8),
                                Text('$points', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
                              ]
                            ),
                          )) : Container(),
                          SizedBox(width: points != null ? 16 : 0),
                          points != null ? Expanded(child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/exp.png', width: 32),
                                SizedBox(width: 8),
                                Text('$exp', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
                              ]
                            ),
                          )) : Container(),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 58,
                  padding: EdgeInsets.symmetric(horizontal: 24) ,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.white,
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF0C0C0D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Claim', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                Spacer(),
              ],
            )
          ),
          Positioned(bottom: 240, right: 0, child: Image.asset('assets/images/home/gold_box.png', width: 160))
        ],
      )
    );
  }
}