import 'package:baidyet/components/app_layout.dart';
import 'package:flutter/material.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      showBottomNav: true,
      currentIndex: 4,
      child: Center(
        child: Text('Education Page'),
      ),
    );
  }
}
