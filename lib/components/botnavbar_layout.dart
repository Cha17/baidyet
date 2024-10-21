import 'package:baidyet/components/background.dart';
import 'package:baidyet/pages/add_button.dart';
import 'package:baidyet/pages/budget.dart';
import 'package:baidyet/pages/educ.dart';
import 'package:baidyet/pages/home_page.dart';
import 'package:baidyet/pages/insights.dart';
import 'package:flutter/material.dart';

class BotNavBarLayout extends StatefulWidget {
  const BotNavBarLayout({Key? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<BotNavBarLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Budget(),
    AddButton(),
    Insights(),
    Education(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.add_circle_rounded),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF1A2A57),
        selectedItemColor: Color(0xFFDAA520),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
