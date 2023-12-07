import 'package:flutter/material.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/screens/games/games_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
      // color: const Color.fromARGB(
      //     100, 160, 197, 172), // Two times lighter (you can adjust as needed)
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Image.asset(
                // 'assets/logo.jpg',
                'assets/diner_logo_slogan.png',
                fit: BoxFit.scaleDown,
                // 'assets/logo.jpg',,
              ),
            ),
          ),
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
          Visibility(
            visible: adminMode,
            child: ListTile(
              title: const Text(
                'Exit Admin Mode',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 87, 87),
                ),
              ),
              leading: const Icon(
                  Icons.admin_panel_settings), // Icon for the 'Games' tab
              onTap: () {
                adminMode = false;
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
