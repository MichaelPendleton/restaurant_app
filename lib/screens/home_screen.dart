import 'package:flutter/material.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/screens/menu_screen.dart';
import 'package:restaurant_app/screens/games/games_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFEAEAEA), // Light grey background color
        child: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: Image.asset(
                    'assets/diner_logo_slogan.png',
                    width: MediaQuery.of(context).size.width * 0.90,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      adminMode = true;
                    });
                  },
                  child: SizedBox(
                    width: 360,
                    height: 70,
                    child: adminMode
                        ? (ElevatedButton(
                            onPressed: () {
                              setState(() {
                                adminMode = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 87, 87),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 8.0,
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              shadowColor: Colors.grey,
                            ),
                            child: const Text(
                              'Exit Admin Mode',
                              style: TextStyle(fontSize: 30),
                            ),
                          ))
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.425,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the MenuScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 160, 197, 172),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 8.0,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          shadowColor: Colors.grey,
                        ),
                        child: Text(
                          'Menu',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .075),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the GamesScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamesScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 163, 163, 211),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 8.0,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          shadowColor: Colors.grey,
                        ),
                        child: Text(
                          'Games',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .075),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
