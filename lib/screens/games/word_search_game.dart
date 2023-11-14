// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class WordSearchGame extends StatefulWidget {
  const WordSearchGame({super.key});

  @override
  _WordSearchGameState createState() => _WordSearchGameState();
}

class _WordSearchGameState extends State<WordSearchGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5), // Adjust padding as needed
            child: Text("Word Search"),
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
          child: Text("Word Search"),
        ),
      ),
    );
  }
}
