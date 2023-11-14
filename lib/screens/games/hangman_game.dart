// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5), // Adjust padding as needed
            child: Text("Hangman"),
          ),
          leading: Padding(
            padding:
                const EdgeInsets.only(right: 5), // Adjust padding as needed
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back), // Drawer icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: const Center(
          child: Text("Hangman"),
        ),
      ),
    );
  }
}
