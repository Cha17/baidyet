import 'package:baidyet/pages/app_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      child: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
