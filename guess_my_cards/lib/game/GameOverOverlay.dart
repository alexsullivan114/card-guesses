import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/models/Team.dart';

class GameOverOverlay extends StatelessWidget {
  final Team _winningTeam;

  GameOverOverlay(this._winningTeam);

  @override
  Widget build(BuildContext context) {
    String text = _winningTeam == Team.Red ? "Red" : "Blue";
    Color textColor = _winningTeam == Team.Red ? Colors.red : Colors.blue;
    return Container(
      color: Colors.black87,
      child: Center(
        child: RichText(
            text: TextSpan(style: TextStyle(fontSize: 38.0), children: [
          TextSpan(text: text, style: TextStyle(color: textColor)),
          TextSpan(text: " team won!")
        ])),
      ),
    );
  }
}
