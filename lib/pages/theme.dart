import 'package:flutter/material.dart';
import '/widgets/common.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
    return CommonPage(
      child: Container()
    );
	}
}