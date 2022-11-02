import 'package:flutter/material.dart';

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
  List<String> grid =[
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

  var textStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: Container(
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Player O', style: textStyle),
                      Text(ohScore.toString(), style: textStyle,),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: textStyle),
                        Text(exScore.toString(), style: textStyle,),
                      ],),
                    )
                ],),
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
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);
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
              )
          )
        ]
      ),
    );
  }
   void _tapped(int index) {
    setState(() {
      if (ohTurn && grid[index] == '') {
        grid[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && grid[index] == '') {
        grid[index] = 'X';
        filledBoxes += 1;
      }
      // grid = 'O';

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

    void _checkWinner() {
    // prima riga
    if (grid[0] == grid[1] &&
        grid[0] == grid[2] &&
        grid[0] != '') {
      _showWinDialog(grid[0]);
    }

    // seconda riga
    if (grid[3] == grid[4] &&
        grid[3] == grid[5] &&
        grid[3] != '') {
      _showWinDialog(grid[3]);
    }

    //  terza riga
    if (grid[6] == grid[7] &&
        grid[6] == grid[8] &&
        grid[6] != '') {
      _showWinDialog(grid[6]);
    }

    // prima colonna
    if (grid[0] == grid[3] &&
        grid[0] == grid[6] &&
        grid[0] != '') {
      _showWinDialog(grid[0]);
    }

    // seconda colonna
    if (grid[1] == grid[4] &&
        grid[1] == grid[7] &&
        grid[1] != '') {
      _showWinDialog(grid[1]);
    }

    // terza colonna
    if (grid[2] == grid[5] &&
        grid[2] == grid[8] &&
        grid[2] != '') {
      _showWinDialog(grid[2]);
    }

    // diagonali
    if (grid[6] == grid[4] &&
        grid[6] == grid[2] &&
        grid[6] != '') {
      _showWinDialog(grid[6]);
    }

    if (grid[0] == grid[4] &&
        grid[0] == grid[8] &&
        grid[0] != '') {
      _showWinDialog(grid[0]);
    }

    else if(filledBoxes == 9){
      _showDrawDialog();
    }
  }
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('DRAW'),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text('Play Again!'),
              ),],
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
            title: Text('WINNER: $winner', style: textStyle),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
          child: const Text('Play Again!'),
              ),],
          );
        });
    if(winner == 'O') {
      ohScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for(int i=0; i<9; i++){
        grid[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
