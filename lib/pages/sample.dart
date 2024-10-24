import 'package:baidyet/components/background.dart';
import 'package:baidyet/components/constants/colors.dart';
import 'package:baidyet/pages/main_pages/add_button.dart';
import 'package:baidyet/pages/main_pages/budget.dart';
import 'package:baidyet/pages/main_pages/educ.dart';
import 'package:baidyet/pages/main_pages/home_page.dart';
import 'package:baidyet/pages/main_pages/insights.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  final Widget child;
  final bool showBottomNav;
  final int? currentIndex;
  final Function(int)? onNavigationChanged;

  const Sample({
    super.key,
    required this.child,
    this.showBottomNav = false,
    this.currentIndex,
    this.onNavigationChanged,
  });

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  void _handleNavigation(int index) {
    if (widget.onNavigationChanged != null) {
      widget.onNavigationChanged!(index);
    }

    // Only navigate if we're moving to a different page
    if (index == widget.currentIndex) return;

    Widget nextPage;
    // Navigate to appropriate page based on index
    switch (index) {
      case 0:
        nextPage = const HomePage();
        break;
      case 1:
        nextPage = const Budget();
        break;
      case 2:
        nextPage = const AddButton();
        break;
      case 3:
        nextPage = const Insights();
        break;
      case 4:
        nextPage = const Education();
        break;
      default:
        return;
    }

    // Simple page replacement without animation
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextPage,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  final List<Widget> _botNavBarItems = [
    const Icon(
      Icons.home_rounded,
      color: yColor,
    ),
    const Icon(Icons.account_balance_wallet_rounded, color: yColor),
    const Icon(Icons.add_circle_rounded, color: yColor),
    const Icon(Icons.insights_rounded, color: yColor),
    const Icon(Icons.book_rounded, color: yColor),
  ];
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
      bottomNavigationBar: CurvedNavigationBar(
        items: _botNavBarItems,
        color: bColor,
        backgroundColor: Colors.transparent.withOpacity(0.0),
      ),
    );
  }
}
