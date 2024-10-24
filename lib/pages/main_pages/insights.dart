import 'package:baidyet/components/app_layout.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      showBottomNav: true,
      currentIndex: 3,
      child: Center(
        child: Text('Insights Page'),
      ),
    );
  }
}
