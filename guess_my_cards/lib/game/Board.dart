import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/game/GuessWordConfirmation.dart';
import 'package:guess_my_cards/game/clueDisplay/AwaitingClueDisplay.dart';
import 'package:guess_my_cards/game/clueDisplay/ClueDisplay.dart';
import 'package:guess_my_cards/game/clueDisplay/ClueInput.dart';
import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Role.dart';
import 'package:guess_my_cards/models/Team.dart';

import 'WordCard.dart';

class Board extends StatefulWidget {
  final Game game;
  final Role userRole;
  final Team team;
  final GameCode _code;

  Board(this.game, this.userRole, this.team, this._code);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var loading = false;

  void _handleClueInput(Clue clue) async {
    setState(() {
      this.loading = true;
    });
    final result = await postClue(clue, widget._code);
    setState(() {
      this.loading = false;
    });

    if (!result.isSuccess()) {
      final snackbar = SnackBar(
        content: Text("Woops. We messed up sending your clue. Try again!"),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  void _handleWordPressed(Word word, BuildContext context) async {
    if (widget.userRole != Role.Master &&
        widget.game.currentRound.teamUp == widget.team &&
        word.guessStatus != GuessStatus.Guessed) {
      showDialog(context: context, builder: (BuildContext context) {
        return GuessWordConfirmationDialog(word, widget.team, widget._code);
      });
    }
  }

  Widget _clueDisplay() {
    if (widget.game.currentRound.clue != null) {
      return ClueDisplay(
          widget.game.currentRound.clue, widget.game.currentRound.teamUp,
          widget.userRole, widget._code);
    } else if (widget.userRole == Role.Master &&
        widget.game.currentRound.teamUp == widget.team) {
      return ClueInput(_handleClueInput, loading);
    } else {
      return AwaitingClueDisplay(widget.game.currentRound.teamUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.game.words.map((word) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: WordCard(word, widget.userRole, (Word word) {
          _handleWordPressed(word, context);
        }),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.game.gameCode.code}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 0.7,
            children: cards,
          ),
          Padding(padding: const EdgeInsets.all(16.0), child: _clueDisplay())
        ],
      ),
    );
  }
}
