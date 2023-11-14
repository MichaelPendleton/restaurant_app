// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  @override
  Widget build(BuildContext context) {
    var screen_width = MediaQuery.of(context).size.width;
    Color blueColor = Color.fromARGB(255, 35, 33, 167);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5), // Adjust padding as needed
            child: Text("Tic Tac Toe"),
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
          child: Column(
            children: [
              Row(
                children: [
                  // IconButton(
                  // icon: const Icon(Icons.arrow_back), // Drawer icon
                  // onPressed: () {
                  //   Navigator.pop(context);
                  // },
                  // ),
                  // FloatingActionButton(
                  //   // backgroundColor: c,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
              Row(),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
