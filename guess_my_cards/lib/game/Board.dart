import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/game/ClueInput.dart';
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
    final widgets = game.words.map((word) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: WordCard(word, userRole, _handleWordPressed),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${game.gameCode.code}",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 0.7,
            children: widgets,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClueInput(_handleClueInput))
        ],
      ),
    );
  }
}
