import 'package:baidyet/components/app_layout.dart';
import 'package:flutter/material.dart';

class Budget extends StatelessWidget {
  const Budget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      showBottomNav: true,
      currentIndex: 1,
      child: Center(
        child: Text("Budget"),
      ),
    );
  }
}
