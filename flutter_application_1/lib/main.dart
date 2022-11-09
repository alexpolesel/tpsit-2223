import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ohTurn = true;
  List<String> grid = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  var titleStyle = const TextStyle(color: Colors.white, fontSize: 30);
  var textStyle = const TextStyle(color: Colors.white);

  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;
  bool IA = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // scelgo il colore del bottone
              ),
              onPressed: () {
                setState(() {
                  IA = !IA;
                  _clearBoard();
                });
              },
              child: Text(IA ? 'IA' : '1v1')),
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O', style: titleStyle),
                      Text(
                        ohScore.toString(),
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X', style: titleStyle),
                      Text(
                        exScore.toString(),
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _pressed(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700)),
                        child: Center(
                          child: Text(
                            grid[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ))
      ]),
    );
  }

  void _pressed(int index) {
    if (grid[index] != '') return;
    setState(() {
      if (ohTurn) {
        grid[index] = 'O';
        filledBoxes += 1;
        if (!IA) {
          ohTurn = !ohTurn;
          return;
        }
      }
      if (IA) {
        var rng = Random();
        bool done = false;
        if (filledBoxes < 8) {
          while (!done) {
            int n = rng.nextInt(8);
            if (grid[n] == '') {
              grid[n] = 'X';
              done = true;
              filledBoxes += 1;
            }
          }
        }
        return;
      }
      if (!ohTurn) {
        grid[index] = 'X';
        filledBoxes += 1;
        ohTurn = !ohTurn;
        return;
      }
    });
    _checkWinner();
  }

  void _checkWinner() {
    bool win = false;
    // prima riga
    if (grid[0] == grid[1] && grid[0] == grid[2] && grid[0] != '') {
      _showWinDialog(grid[0]);
      win = true;
    }

    // seconda riga
    if (grid[3] == grid[4] && grid[3] == grid[5] && grid[3] != '') {
      _showWinDialog(grid[3]);
      win = true;
    }

    //  terza riga
    if (grid[6] == grid[7] && grid[6] == grid[8] && grid[6] != '') {
      _showWinDialog(grid[6]);
      win = true;
    }

    // prima colonna
    if (grid[0] == grid[3] && grid[0] == grid[6] && grid[0] != '') {
      _showWinDialog(grid[0]);
      win = true;
    }

    // seconda colonna
    if (grid[1] == grid[4] && grid[1] == grid[7] && grid[1] != '') {
      _showWinDialog(grid[1]);
    }

    // terza colonna
    if (grid[2] == grid[5] && grid[2] == grid[8] && grid[2] != '') {
      _showWinDialog(grid[2]);
      win = true;
    }

    // diagonali
    if (grid[6] == grid[4] && grid[6] == grid[2] && grid[6] != '') {
      _showWinDialog(grid[6]);
      win = true;
    }

    if (grid[0] == grid[4] && grid[0] == grid[8] && grid[0] != '') {
      _showWinDialog(grid[0]);
      win = true;
    }

    if (filledBoxes == 9 && !win) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('DRAW'),
            titleTextStyle: titleStyle,
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again!', style: textStyle),
              ),
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              'WINNER: $winner',
              style: titleStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again!', style: textStyle),
              ),
            ],
          );
        });
    if (winner == 'O') {
      ohScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        grid[i] = '';
      }
    });
    filledBoxes = 0;
    ohTurn = true;
  }
}
