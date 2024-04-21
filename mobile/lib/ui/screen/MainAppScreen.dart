import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trgovinavigator/logic/product_item.dart';
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

  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      ShoppingListSelectorScreen(onUse: (products) async {
        // Navigate to map screen
        final newPos = products.map((e) {
          return getOffsetForProduct(e);
        }).toList();
        final newPositionsWaited = <FractionalOffset>[];
        for (final np in newPos) {
          final newPs = await np;
          newPositionsWaited.add(newPs);
        }
        (_children[2] as MapScreen).updateObjectPositions(newPositionsWaited);
        onTabTapped(2);
        print(products.map((e) => e.ime_izdelka));
      }),
      const StatsScreen(),
      const MapScreen(),
    ];
  }

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
            label: 'Seznam',
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

Future<FractionalOffset> getOffsetForProduct(ProductItem e) async {
  // Should return offset 0 ... 1
  // Get polica for product
  final police = await Supabase.instance.client
      .from("police")
      .select("*")
      .eq("id_police", e.id_police)
      .select("x, y")
      .limit(1);
  final polica = police[0];
  return FractionalOffset(polica["x"] as double, polica["y"] as double);
}
