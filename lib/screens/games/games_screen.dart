import 'package:flutter/material.dart';
import 'package:restaurant_app/main.dart';
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
      debugShowCheckedModeBanner: false,
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
                Color.fromARGB(255, 160, 197, 172),
                Colors.white,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 8.0, // Text color when pressed
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      shadowColor: const Color.fromARGB(255, 160, 197, 172),
                    ),
                    child: Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .075),
                    ),
                  ),
                ),
                const SizedBox(height: 45), // Increase spacing between buttons
                SizedBox(
                  width: 290,
                  height: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the Word Search screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WordScrambleGame(),
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
                      'Word Scramble',
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
                      // Navigate to the Hangman screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HangmanGame(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 8.0,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      shadowColor: Colors.white,
                    ),
                    child: Text(
                      'Hangman',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .075),
                    ),
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
