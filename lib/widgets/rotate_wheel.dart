import 'package:flutter/material.dart';
import 'dart:math';

class RotatingWheel extends StatefulWidget {
  final Image image;
  final AnimationController controller;

  const RotatingWheel({
    super.key,
    required this.image,
    required this.controller,
  });

  @override
  _RotatingWheelState createState() => _RotatingWheelState();
}

class _RotatingWheelState extends State<RotatingWheel> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.controller.value * 2 * pi, // 将0-1的值转换为弧度（0-2π）
          child: widget.image,
        );
      },
    );
  }
}