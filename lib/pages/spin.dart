import 'package:flutter/material.dart';
import '/widgets/common.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({super.key});
  @override
  State<SpinPage> createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
    return CommonPage(
      child: Column(
        children: [
          SizedBox(height: 8),
          Image.asset('assets/images/spin/title.png', height: 24),
          SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/spin/spin_base.png', width: 370),
              Positioned(child: Image.asset('assets/images/spin/spin_panel.png', width: 284)),
              Positioned(child: Image.asset('assets/images/spin/spin_rewards.png', width: 242)),
              Positioned(top: 8, child: Image.asset('assets/images/spin/spin_finger.png', width: 32)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 32),
                SizedBox(
                  width: 242,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.8),
                      backgroundColor: Color(0xFFFF006C),
                      disabledBackgroundColor: Color(0xFF35363C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: null,
                    child: Text('Free Spin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 242,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.8),
                      backgroundColor: Color(0xFFFFAA00),
                      disabledBackgroundColor: Color(0xFF35363C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Spin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(width: 6),
                        Image.asset('assets/icons/Love_disabled.png', width: 24),
                        Text('500', style: TextStyle(fontWeight: FontWeight.w600))
                      ],
                    )
                  ),
                )
              ],
            )
          )
        ],
      )
    );
	}
}