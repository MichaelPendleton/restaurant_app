import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/menu_screen.dart';
import 'package:restaurant_app/screens/games_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 125,
              ),
              child: Image.asset(
                'assets/logo.jpg',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the MenuScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                  ),
                  child: const Text(
                    'Menu',
                    style: TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the GamesScreen (replace with your screen)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GamesScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                  ),
                  child: const Text(
                    'Games',
                    style: TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
