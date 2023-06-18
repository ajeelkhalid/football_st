import 'package:flutter/material.dart';
import './colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: themeColor,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xffFFFFFF),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: '•',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_sharp),
          label: '•',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_line_chart),
          label: '•',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '•',
        ),
      ],
    );
  }
}
