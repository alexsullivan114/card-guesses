import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/Role.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final Role userRole;
  final void Function(Word) _wordSelectedCallback;

  WordCard(this.word, this.userRole, this._wordSelectedCallback);

  @override
  Widget build(BuildContext context) {
    Color cardOwnerColor;
    switch (word.owner) {
      case CardOwner.Red:
        cardOwnerColor = Colors.red;
        break;
      case CardOwner.Blue:
        cardOwnerColor = Colors.blue;
        break;
      case CardOwner.Unowned:
        cardOwnerColor = Colors.yellow.shade700;
        break;
      case CardOwner.Assassin:
        cardOwnerColor = Colors.black;
        break;
    }

    final borderColor =
        userRole == Role.Master || word.guessStatus == GuessStatus.Guessed
            ? cardOwnerColor
            : Colors.yellow.shade700;

    final fillColor = word.guessStatus == GuessStatus.Guessed
        ? cardOwnerColor
        : Colors.transparent;

    return InkWell(
      onTap: () => _wordSelectedCallback(word),
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(width: 3.0, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
            child: Text(
          word.text,
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
