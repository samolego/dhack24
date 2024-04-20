import 'package:flutter/material.dart';
import 'package:trgovinavigator/ui/screen/MapScreen.dart';
import 'package:trgovinavigator/ui/screen/ShopScanScreen.dart';
import 'package:trgovinavigator/ui/screen/ShoppingListScreen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    const ShoppingListScreen(),
    const MapScreen(),
    const ShopScanScreen(),
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
            label: 'Shopping list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Add shop',
          ),
        ],
      ),
    );
  }
}
