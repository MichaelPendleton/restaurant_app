// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

int turnNumber = 0;

Color blueColor = const Color.fromARGB(255, 35, 33, 167);
Color redColor = const Color.fromARGB(255, 167, 33, 33);
Color greyColor = const Color.fromARGB(57, 48, 47, 47);

bool gameOver = false;
String gameStatus = 'Blue\'s Turn';

List<Color> initialBoardColors = [
  greyColor,
  greyColor,
  greyColor,
  greyColor,
  greyColor,
  greyColor,
  greyColor,
  greyColor,
  greyColor
];

List<Color> boardColors = initialBoardColors;

class _TicTacToeGameState extends State<TicTacToeGame> {
  @override
  void initState() {
    super.initState();
  }

  InkWell _drawBox(double size, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _decideColor(index);
          _gameStatus();
        });
      },
      child: Card(
        color: boardColors.elementAt(index),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SizedBox(
          width: size,
          height: size,
        ),
      ),
    );
  }

  void _decideColor(int index) {
    if (!gameOver && boardColors.elementAt(index) == greyColor) {
      if (turnNumber % 2 == 1) {
        boardColors[index] = redColor;
        turnNumber++;
      } else {
        boardColors[index] = blueColor;
        turnNumber++;
      }
    } else {
      // ScaffoldMessenger.of(context).clearSnackBars();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Click on an empty space.'),
      //   ),
      // );
    }
  }

  void _gameStatus() {
    if ((boardColors[0] != greyColor &&
            boardColors[0] == boardColors[1] &&
            boardColors[1] == boardColors[2]) ||
        (boardColors[3] != greyColor &&
            boardColors[3] == boardColors[4] &&
            boardColors[4] == boardColors[5]) ||
        (boardColors[6] != greyColor &&
            boardColors[6] == boardColors[7] &&
            boardColors[7] == boardColors[8]) ||
        (boardColors[0] != greyColor &&
            boardColors[0] == boardColors[3] &&
            boardColors[3] == boardColors[6]) ||
        (boardColors[1] != greyColor &&
            boardColors[1] == boardColors[4] &&
            boardColors[4] == boardColors[7]) ||
        (boardColors[2] != greyColor &&
            boardColors[2] == boardColors[5] &&
            boardColors[5] == boardColors[8]) ||
        (boardColors[4] != greyColor &&
            boardColors[0] == boardColors[4] &&
            boardColors[4] == boardColors[8]) ||
        (boardColors[4] != greyColor &&
            boardColors[2] == boardColors[4] &&
            boardColors[4] == boardColors[6])) {
      gameOver = true;
      if (turnNumber % 2 == 0) {
        gameStatus = 'RED WON!!!';
      } else {
        gameStatus = 'BLUE WON!!!';
      }
    } else if (turnNumber == 9) {
      gameOver = true;
      gameStatus = 'Cat\'s Game... Tie.';
    }
  }

  @override
  Widget build(BuildContext context) {
    var boxSize = (MediaQuery.of(context).size.width / 20) * 5;

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(gameOver
                  ? gameStatus
                  : (turnNumber % 2 == 0 ? 'Blue\'s Turn' : 'Red\'s Turn')),
              Visibility(
                visible: gameOver,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          for (int i = 0; i < boardColors.length; i++) {
                            boardColors[i] = greyColor;
                          }
                          turnNumber = 0;
                          gameOver = false;
                        });
                      },
                      label: const Text('Restart Game'),
                      icon: const Icon(Icons.replay_outlined),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Visibility(
                visible: !gameOver,
                child: const SizedBox(height: 100),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawBox(boxSize, 0),
                  _drawBox(boxSize, 1),
                  _drawBox(boxSize, 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawBox(boxSize, 3),
                  _drawBox(boxSize, 4),
                  _drawBox(boxSize, 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawBox(boxSize, 6),
                  _drawBox(boxSize, 7),
                  _drawBox(boxSize, 8),
                ],
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
