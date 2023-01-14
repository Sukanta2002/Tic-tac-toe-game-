import 'package:flutter/material.dart';

import 'package:tic_tac_toe_game/custom_diologue.dart';
import 'package:tic_tac_toe_game/game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonlist;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();

    buttonlist = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);

    setState(() {
      buttonlist = doInit();
    });
  }

  int checkWinner() {
    var winner = -1;
    //row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    //row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    //row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    //col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    //col  2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    //col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    //diagonal 1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    //diagonal 2
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue('Player 1 Won',
                'Please press the reset button to start ', resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue('Player 2 Won',
                'Please press the reset button to start ', resetGame));
      }
    }
    return winner;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = 'O';
        gb.bg = Colors.black;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = 'X';
        gb.bg = Colors.blue;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      var winner = checkWinner();
      if (winner == -1) {
        if (buttonlist.every((element) => element.text != '')) {
          showDialog(
              context: context,
              builder: (_) => CustomDialogue('Game Tied',
                  'Please press the reset button to start', resetGame));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xfff6921e), Color(0xffee4036)])),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 9.0,
                            crossAxisSpacing: 6.0),
                    itemCount: buttonlist.length,
                    itemBuilder: (context, index) => SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: buttonlist[index].enabled
                                  ? () => playGame(buttonlist[index])
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonlist[index].bg,
                                  disabledBackgroundColor:
                                      buttonlist[index].bg),
                              child: Text(
                                buttonlist[index].text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 50.0),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: resetGame,
                child: const Text('RESET'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              ),
            )
          ],
        ),
      ),
    );
  }
}
