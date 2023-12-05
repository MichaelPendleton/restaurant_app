// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/drawer_screen.dart';
import 'package:restaurant_app/widgets/menu_item_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      drawer: const Drawer(
        child: DrawerScreen(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 160, 197, 172),
            ],
          ),
        ),
        // Remove the background color property
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                        selection: Selection.entree,
                        isKidsFilter: _currentIndex == 1,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor: const Color.fromARGB(255, 160, 197, 172),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                ).merge(
                  ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                child: const Text('Entrees'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                        selection: Selection.side,
                        isKidsFilter: _currentIndex == 1,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor: const Color.fromARGB(255, 163, 163, 211),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                ).merge(
                  ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                child: const Text('Sides'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MenuItemList(
                        selection: Selection.beverage,
                        isKidsFilter: _currentIndex == 1,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor:
                      Colors.white, // Set the background color to white
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                  // shadowColor: Colors.red,
                ).merge(
                  const ButtonStyle(
                      // No need to change the foregroundColor for normal font color
                      ),
                ),
                child: const Text('Beverages'),
              ),
            ],
          ),
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
    );
  }
}
