import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/models/Team.dart';

class AwaitingClueDisplay extends StatelessWidget {
  final Team _awaitingTeam;

  AwaitingClueDisplay(this._awaitingTeam);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 28.0, color: Colors.black),
            children: [
          TextSpan(text: "Waiting for"),
          TextSpan(
              text: " ${_awaitingTeam.name}",
              style: TextStyle(color: _awaitingTeam.color)),
          TextSpan(text: " team's clue..."),
        ]));
  }
}
