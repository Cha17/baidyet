import 'package:baidyet/components/background.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Background(child: SizedBox.shrink()),
            widget.child,
          ],
        ),
      ),
    );
  }
}
