import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/game/clueDisplay/AwaitingClueDisplay.dart';
import 'package:guess_my_cards/game/clueDisplay/ClueDisplay.dart';
import 'package:guess_my_cards/game/clueDisplay/ClueInput.dart';
import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/Role.dart';
import 'package:guess_my_cards/models/Team.dart';

import 'WordCard.dart';

class Board extends StatelessWidget {
  final Game game;
  final Role userRole;
  final Team team;
  final void Function(Word) _handleWordPressed;
  final void Function(Clue) _handleClueInput;

  Board(this.game, this.userRole, this.team, this._handleWordPressed,
      this._handleClueInput);

  @override
  Widget build(BuildContext context) {
    final cards = game.words.map((word) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: WordCard(word, userRole, _handleWordPressed),
      );
    }).toList();

    Widget clueDisplay;
    if (game.currentRound.clue != null) {
      clueDisplay = ClueDisplay(game.currentRound.clue, game.currentRound.teamUp);
    } else if (userRole == Role.Master && game.currentRound.teamUp == team) {
      clueDisplay = ClueInput(_handleClueInput);
    } else {
      clueDisplay = AwaitingClueDisplay(game.currentRound.teamUp);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${game.gameCode.code}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 0.7,
            children: cards,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: clueDisplay
          )
        ],
      ),
    );
  }
}
