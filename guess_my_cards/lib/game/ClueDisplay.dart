import 'package:flutter/material.dart';
import 'package:guess_my_cards/models/Clue.dart';

class ClueDisplay extends StatelessWidget {
  final Clue _clue;

  ClueDisplay(this._clue);

  @override
  Widget build(BuildContext context) {
    final clue = "Clue: ${_clue?.text ?? "--"}";
    final guesses = "guesses left: ${_clue?.guessesLeft?.toString() ?? "--"}";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          clue,
          style: TextStyle(fontSize: 28),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(guesses),
        ),
      ],
    );
  }
}
