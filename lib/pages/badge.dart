import 'package:flutter/material.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({super.key});
  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
        ),
      )
    );
	}
}