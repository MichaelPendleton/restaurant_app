import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/games_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/menu_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateHome() {
      Navigator.pop(context); // Close the drawer
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: InkWell(
              onTap: navigateHome,
              child: Image.asset(
                'assets/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ListTile(
          //   title: const Text('Home'),
          //   leading: const Icon(Icons.home), // Icon for the 'Home' tab
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     navigateHome;
          //   },
          // ),
          ListTile(
            title: const Text('Menu'),
            leading:
                const Icon(Icons.restaurant_menu), // Icon for the 'Menu' tab
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Games'),
            leading: const Icon(Icons.games), // Icon for the 'Games' tab
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
