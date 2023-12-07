// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/models/menu_item.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor:
            adminMode ? const Color.fromARGB(255, 226, 87, 87) : null,
        actions: [
          Visibility(
            visible: adminMode,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      adminMode = false;
                    });
                  },
                  child: const Text(
                    'Exit Admin Mode',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 290,
                height: 130,
                child: ElevatedButton(
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
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 160, 197, 172),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.grey,
                  ),
                  child: Text(
                    'Entrees',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .075),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: 290,
                height: 130,
                child: ElevatedButton(
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
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 163, 163, 211),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.grey,
                  ),
                  child: Text(
                    'Sides',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .075),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: 290,
                height: 130,
                child: ElevatedButton(
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
                    backgroundColor:
                        Colors.white, // Set the background color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.grey,
                  ),
                  child: Text(
                    'Beverages',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .075),
                  ),
                ),
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
