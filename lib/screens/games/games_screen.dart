// ignore_for_file: library_private_types_in_public_api

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Games'),
        ),
        drawer: const Drawer(
          child: DrawerScreen(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Tic Tac Toe screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TicTacToeGame()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Tic Tac Toe'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Word Search screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WordSearchGame()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Word Search'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Hangman screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HangmanGame()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Hangman'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
