import 'package:flutter/material.dart';

class WordSearchGame extends StatefulWidget {
  const WordSearchGame({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _WordSearchGameState createState() => _WordSearchGameState();
}

class _WordSearchGameState extends State<WordSearchGame>
    with SingleTickerProviderStateMixin {
  int currentPuzzle = 0;

  // /// List of Questions
  // List<String> questions = [
  //   "What is the name of this food?",
  // ];

  /// List of Answers
  List<String> answers = ["pasta", "soup", "salad"];

  /// List of Images
  List<String> currentImages = [
    "assets/food/food-game-image-1.jpg",
    "assets/food/food-game-image-2.jpg",
    "assets/food/food-game-image-3.jpg",
  ];
  List<String> alphabet = [];
  List<String> userAnswers = [];
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    generateAlphabetOptions();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Generate Alphabets
  void generateAlphabetOptions() {
    alphabet = answers[currentPuzzle].split('');
    alphabet.shuffle();
    userAnswers = List.filled(answers[currentPuzzle].length, '');
  }

  /// Check Answer
  void checkAnswer() {
    if (userAnswers.join('') == answers[currentPuzzle]) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Correct Answer!'),
            content: const Text('Congratulations! You got it right.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (currentPuzzle == answers.length - 1) {
                    // Last puzzle, show completion message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Puzzle Completed'),
                          content:
                              const Text('You have completed all the puzzles.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  currentPuzzle = 0;
                                  generateAlphabetOptions();
                                });
                              },
                              child: const Text('Restart'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Next puzzle
                    setState(() {
                      currentPuzzle++;
                      generateAlphabetOptions();
                    });
                  }
                },
                child: const Text('Next'),
              ),
            ],
          );
        },
      ).then((_) {
        _animationController.reset();
        _animationController.forward();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Incorrect Answer!'),
            content: Text('Please try again.'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5), // Adjust padding as needed
          child: Text("Word Search"),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 5), // Adjust padding as needed
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        // questions[currentPuzzle],
                        "What food is this?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            currentImages[currentPuzzle],
                            width: 300,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(userAnswers.length, (index) {
                          return DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      userAnswers[index].isEmpty
                                          ? ' '
                                          : userAnswers[index],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              );
                            },
                            onAccept: (data) {
                              setState(() {
                                userAnswers[index] = data;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 500,
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: alphabet.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Draggable<String>(
                                      data: alphabet[index],
                                      feedback: Material(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              alphabet[index],
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                      childWhenDragging: Container(),
                                      child: Material(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              alphabet[index],
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(width: 10,),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: checkAnswer,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Check Answer',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
