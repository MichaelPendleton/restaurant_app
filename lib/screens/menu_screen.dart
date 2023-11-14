// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/drawer_screen.dart';
import 'package:restaurant_app/widgets/menu_item_list.dart';
import 'package:restaurant_app/widgets/new_menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          //Temporary Add Menu Item Button
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewMenuItem(),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Handle the "Entrees" button press
                  print('Entrees button pressed');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                          selection: Selection.entree,
                          isKids: false /*Needs variable*/),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Entrees'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle the "Sides" button press
                  print('Sides button pressed');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                          selection: Selection.side,
                          isKids: false /*Needs variable*/),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Sides'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle the "Beverages" button press
                  print('Beverages button pressed');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                          selection: Selection.beverage,
                          isKids: false /*Needs variable*/),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Beverages'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Adults',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly),
              label: 'Kids',
            ),
          ],
        ),
      ),
    );
  }
}
