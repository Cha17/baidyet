import 'package:baidyet/components/background.dart';
import 'package:baidyet/components/constants/colors.dart';
import 'package:baidyet/pages/main_pages/add_button.dart';
import 'package:baidyet/pages/main_pages/budget.dart';
import 'package:baidyet/pages/main_pages/educ.dart';
import 'package:baidyet/pages/main_pages/home_page.dart';
import 'package:baidyet/pages/main_pages/insights.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  final bool showBottomNav;
  final int? currentIndex;
  final Function(int)? onNavigationChanged;
  final bool showFloatingButton;
  final Function()? floatingFunction;

  const AppLayout({
    super.key,
    required this.child,
    this.showBottomNav = false,
    this.currentIndex,
    this.onNavigationChanged,
    this.showFloatingButton = false,
    this.floatingFunction,
  });

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
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
      bottomNavigationBar: widget.showBottomNav
          ? BottomNavigationBar(
              currentIndex: widget.currentIndex ?? 0,
              onTap: _handleNavigation,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  label: 'Budget',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_rounded, size: 40),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insights_rounded),
                  label: 'Insights',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_rounded),
                  label: 'Education',
                ),
              ],
              backgroundColor: bColor,
              selectedItemColor: yColor,
              unselectedItemColor: Colors.white,
            )
          : null,
      floatingActionButton: widget.showFloatingButton
          ? FloatingActionButton(
              onPressed: widget.floatingFunction,
              backgroundColor: yColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
