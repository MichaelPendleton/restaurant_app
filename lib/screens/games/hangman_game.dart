import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/words.dart';

class AppColor {
  static Color primaryColor = const Color.fromARGB(100, 160, 197, 172);
  static Color primaryColorDark = const Color.fromARGB(255, 160, 197, 172);
}

class Game {
  static int tries = 0;
  static List<String> selectedChar = [];
}

Widget figureImage(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: Container(
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
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: AppColor.primaryColorDark,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Visibility(
      visible: !hidden,
      child: Text(
        character,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
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
    return word.split('').every((letter) {
      return Game.selectedChar.contains(letter.toUpperCase());
    });
  }

  bool isGameOver() {
    return Game.tries >= 6; // Adjust the threshold as needed
  }

  void resetGame() {
    setState(() {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set the color to white
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.maybePop(context);
            } else {
              print("Nowhere to pop");
            }
          },
        ),
        title: const Text(
          "Hangman",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
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
          isWordGuessed()
              ? const Text(
                  'You won!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          isGameOver()
              ? const Text(
                  'Try again!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 240, 165, 159),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
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
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
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
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Reset button
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
        ],
      ),
    );
  }
}
