import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:rock_paper_scisor_game/screens/results_screen.dart';
import 'package:rock_paper_scisor_game/utilis/game.dart';
import 'package:rock_paper_scisor_game/widgets/button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _selectedChoice;

  @override
  void initState() {
    super.initState();
    _selectedChoice = "";
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x > 10 || event.y > 10 || event.z > 10) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(GameChoice(_selectedChoice)),
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 30, 46, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.gameScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            /* Setting the Game play pad */
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width / 2 -
                          (btnWidth / 2) -
                          20, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Rock",
                        child: gameBtn(() {
                          _selectedChoice = "Rock";
                        }, "assets/rock_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      left: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Scisors",
                        child: gameBtn(() {
                          _selectedChoice = "Scisors";
                        }, "assets/scisor_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      right: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Paper",
                        child: gameBtn(() {
                          _selectedChoice = "Paper";
                        }, "assets/paper_btn.png", btnWidth),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
