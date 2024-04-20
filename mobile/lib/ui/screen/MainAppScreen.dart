import 'package:flutter/material.dart';
import 'package:trgovinavigator/ui/screen/MapScreen.dart';
import 'package:trgovinavigator/ui/screen/ShoppingListSelectorScreen.dart';
import 'package:trgovinavigator/ui/screen/StatsScreen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const ShoppingListSelectorScreen(),
    const StatsScreen(),
    const MapScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Nakupovalni seznam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Domov',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Zemljevid',
          ),
        ],
      ),
    );
  }
}
