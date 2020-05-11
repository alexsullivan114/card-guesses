import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/game/LoadingDialog.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Guess.dart';
import 'package:guess_my_cards/models/Team.dart';

class GuessWordConfirmationDialog extends StatelessWidget {
  final Word _word;
  final Team _team;
  final GameCode _code;

  GuessWordConfirmationDialog(this._word, this._team, this._code);

  @override
  Widget build(BuildContext context) {
    final message = "Do you rrreeaalllllyyy want to guess ${_word.text}";
    final loadingMessage = "Guessing...";
    final confirmationMessage = "Are you sure?";
    final callback = () async {
      final guess = Guess(_word.text, _team);
      await postGuess(guess, _code);
    };
    return LoadingDialog(
        message, loadingMessage, confirmationMessage, callback);
  }
}

