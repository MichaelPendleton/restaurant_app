import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/words.dart';

class AppColor {
  static Color primaryColor = const Color.fromARGB(100, 160, 197, 172);
  static Color primaryColorDark = const Color.fromARGB(255, 160, 197, 172);
}

bool _gameOver = false;

class Game {
  static int tries = 0;
  static List<String> selectedChar = [];
}

Widget figureImage(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: SizedBox(
      width: 250,
      height: 250,
      child: Image.asset(path),
    ),
  );
}

Widget letter(String character, bool hidden) {
  return Container(
    height: 65,
    width: 50,
    // padding: const EdgeInsets.only(),
    decoration: BoxDecoration(
      color: AppColor.primaryColorDark,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Visibility(
      visible: !hidden,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          character,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
      ),
    ),
  );
}

class HangmanGame extends StatefulWidget {
  const HangmanGame({Key? key}) : super(key: key);

  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  String word = _getRandomWord().toUpperCase();
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  static String _getRandomWord() {
    List<String> words = WordList.words;
    Random random = Random();
    return words[random.nextInt(words.length)];
  }

  bool isWordGuessed() {
    _gameOver = true;
    return word.split('').every((letter) {
      return Game.selectedChar.contains(letter.toUpperCase());
    });
  }

  bool isGameOver() {
    if (Game.tries >= 6) {
      _gameOver = true;
      print(true);
      return true;
    } else {
      print(false);
      return false;
    } // Adjust the threshold as needed
  }

  void resetGame() {
    setState(() {
      _gameOver = false;
      word = _getRandomWord().toUpperCase();
      Game.tries = 0;
      Game.selectedChar.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text("Hangman"),
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
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 220,
            child: Center(
              child: Stack(
                children: [
                  figureImage(Game.tries >= 0, "assets/hang.png"),
                  figureImage(Game.tries >= 1, "assets/head.png"),
                  figureImage(Game.tries >= 2, "assets/body.png"),
                  figureImage(Game.tries >= 3, "assets/ra.png"),
                  figureImage(Game.tries >= 4, "assets/la.png"),
                  figureImage(Game.tries >= 5, "assets/rl.png"),
                  figureImage(Game.tries >= 6, "assets/ll.png"),
                ],
              ),
            ),
          ),
          isWordGuessed()
              ? const Text(
                  'You won!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
          isGameOver()
              ? const Text(
                  'So Close! Try again!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 240, 165, 159),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 230.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e) || isGameOver()
                      ? null
                      : () {
                          setState(() {
                            Game.selectedChar.add(e);
                            if (!word.split('').contains(e.toUpperCase())) {
                              Game.tries++;
                            }
                          });
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.black87
                      : AppColor.primaryColorDark,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          RawMaterialButton(
            onPressed: resetGame,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            fillColor: const Color.fromARGB(
                255, 240, 165, 159), // You can change the color as needed
            child: const Text(
              'Reset',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
