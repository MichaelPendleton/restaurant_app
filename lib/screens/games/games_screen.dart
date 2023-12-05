import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/drawer_screen.dart';
import 'package:restaurant_app/screens/games/hangman_game.dart';
import 'package:restaurant_app/screens/games/tic_tac_toe_game.dart';
import 'package:restaurant_app/screens/games/word_search_game.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(
            255, 160, 197, 172), // Set primary color to #FF5733
        hintColor: const Color.fromARGB(255, 163, 163, 211), // Set accent color
        fontFamily: 'Montserrat', // Use the Montserrat font
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 40.0, // Increase font size
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set text color to white
          ),
          labelLarge: TextStyle(
            fontSize: 50.0, // Increased font size
            color: Colors.white, // Set button text color to white
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Games'),
        ),
        drawer: const Drawer(
          child: DrawerScreen(),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 160, 197, 172),
                Colors.white,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Tic Tac Toe screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicTacToeGame(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 160, 197, 172),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0, // Text color when pressed
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: const Color.fromARGB(255, 160, 197, 172),
                  ),
                  child: const Text(
                    'Tic Tac Toe',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20), // Increase spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Word Search screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WordSearchGame(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 163, 163, 211),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.grey,
                  ),
                  child: const Text(
                    'Word Search',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Hangman screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HangmanGame(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.white,
                  ),
                  child: const Text(
                    'Hangman',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
