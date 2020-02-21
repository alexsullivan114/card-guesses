import 'package:flutter/material.dart';
import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Team.dart';

class ClueDisplay extends StatelessWidget {
  final Clue _clue;
  final Team _teamGuessing;

  ClueDisplay(this._clue, this._teamGuessing);

  @override
  Widget build(BuildContext context) {
    final clue = "${_clue?.text ?? "--"}";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          clue,
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: RichText(text: TextSpan(children: [
            TextSpan(text: _teamGuessing.name, style: TextStyle(color: _teamGuessing.color)),
            TextSpan(text: " team has ${_clue.guessesLeft} guesses left"),
          ], style: TextStyle(color: Colors.black, fontSize: 18))),
        ),
      ],
    );
  }
}
