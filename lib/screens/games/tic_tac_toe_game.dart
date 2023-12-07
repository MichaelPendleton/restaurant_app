// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color.fromARGB(100, 160, 197, 172);
  static Color primaryColorDark = const Color.fromARGB(255, 160, 197, 172);
  static Color blueColor = const Color.fromARGB(100, 35, 33, 167);
  static Color greenColor = const Color.fromARGB(100, 0, 128, 0);
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

int turnNumber = 0;

Color blueColor = Color.fromARGB(255, 33, 35, 167);
Color redColor = const Color.fromARGB(255, 167, 33, 33);
Color greyColor = Colors.white;

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
  greyColor,
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

  Widget _styledMessage(String message, Color boxColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var boxSize = (MediaQuery.of(context).size.width / 20) * 5;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("Tic Tac Toe"),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: AppColor.primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Visibility(
                //   visible: gameOver,
                //   child: _styledMessage(
                //     gameStatus,
                //     gameStatus == 'BLUE WON!!!'
                //         ? AppColor.blueColor
                //         : gameStatus == 'RED WON!!!'
                //             ? redColor
                //             : AppColor.greenColor,
                //   ),
                // ),

                // Visibility(
                //   visible: gameOver,
                //   child: const SizedBox(height: 20),
                // ),
                // Text(
                //   gameOver
                //       ? ''
                //       : (turnNumber % 2 == 0 ? 'Blue\'s Turn' : 'Red\'s Turn'),
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold,
                //     color: turnNumber % 2 == 0 ? blueColor : redColor,
                //   ),
                // ),
                // Visibility(
                //   visible: gameOver,
                //   child: TextButton.icon(
                //     onPressed: () {
                //       setState(() {
                //         for (int i = 0; i < boardColors.length; i++) {
                //           boardColors[i] = greyColor;
                //         }
                //         turnNumber = 0;
                //         gameOver = false;
                //       });
                //     },
                //     label: Text(
                //       'Restart Game',
                //       style: const TextStyle(color: Colors.black),
                //     ),
                //     icon:
                //         const Icon(Icons.replay_outlined, color: Colors.black),
                //   ),
                // ),
                // Visibility(
                //   visible: !gameOver,
                //   child: const SizedBox(height: 100),
                // ),
                Card(
                  color: gameOver
                      ? (gameStatus == 'Cat\'s Game... Tie.'
                          ? const Color.fromARGB(255, 40, 116, 64)
                          : (turnNumber % 2 == 0 ? redColor : blueColor))
                      : (turnNumber % 2 == 0 ? blueColor : redColor),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 65,
                      child: Center(
                        child: gameOver
                            ? Text(
                                gameStatus,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : null,
                      )
                      //     : const Center(
                      //         child: Text(
                      //           'Blue Won!!!',
                      //           style: TextStyle(
                      //               fontSize: 30,
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ))
                      // : null,
                      ),
                ),
                const SizedBox(height: 50),
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
                const SizedBox(height: 50),
                Card(
                  color: gameOver
                      ? Color.fromARGB(255, 40, 116, 64)
                      : (turnNumber % 2 == 0 ? blueColor : redColor),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 65,
                    child: gameOver
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                for (int i = 0; i < boardColors.length; i++) {
                                  boardColors[i] = greyColor;
                                }
                                turnNumber = 0;
                                gameOver = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  (gameStatus == 'Cat\'s Game... Tie.'
                                      ? Color.fromARGB(255, 40, 116, 64)
                                      : (turnNumber % 2 == 0
                                          ? redColor
                                          : blueColor)),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              // elevation: 8.0,
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              // shadowColor: Colors.grey,
                            ),
                            child: const Text(
                              'Restart',
                              style: TextStyle(fontSize: 30),
                            ),
                          )
                        : null,
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   height: 80,
                //   child: ,
                // child: ElevatedButton(
                //   onPressed: () {
                //     if (gameOver) {
                //       for (int i = 0; i < boardColors.length; i++) {
                //         boardColors[i] = greyColor;
                //       }
                //       turnNumber = 0;
                //       gameOver = false;
                //     }
                //   },
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.white,
                //     backgroundColor:
                //         turnNumber % 2 == 0 ? blueColor : redColor,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.zero,
                //     ),
                //     // elevation: 8.0,
                //     textStyle: Theme.of(context).textTheme.labelLarge,
                //     // shadowColor: Colors.grey,
                //   ),
                //   child: turnNumber % 2 == 0
                //       ? const Text(
                //           'Restart',
                //           style: TextStyle(fontSize: 30),
                //         )
                //       : null,
                // ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
