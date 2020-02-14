import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Guess.dart';
import 'package:guess_my_cards/models/Role.dart';
import 'package:guess_my_cards/models/Team.dart';
import 'package:guess_my_cards/storage/preferences.dart';

import 'Board.dart';

class BoardRoute extends StatefulWidget {
  @override
  _BoardRouteState createState() => _BoardRouteState();
}

class _BoardRouteState extends State<BoardRoute> {
  Game game;
  Team team;
  Role role;
  GameCode code;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  void _loadState() async {
    team = await getTeam();
    role = await getRole();
    code = await getGameCode();

    final gameResponse = await getGame(code);

    if (gameResponse.isSuccess()) {
      setState(() {
        this.game = gameResponse.data;
      });
    }
  }

  void _handleWordPressed(Word word) async {
    final guess = Guess(word.text, team);
    final guessResponse = await postGuess(guess, code);
    if (guessResponse.isSuccess()) {
      setState(() {
        game = guessResponse.data;
      });
    } else {
      print("Error: code is ${guessResponse.statusCode}");
    }
  }

  void _handleClueInput(Clue clue) async {
    final clueResponse = await postClue(clue, code);
    if (clueResponse.isSuccess()) {
      setState(() {
        this.game = game;
      });
    } else {
      print("Error submitting clue");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: game == null
                ? Center(child: CircularProgressIndicator())
                : Board(
                    game, role, team, _handleWordPressed, _handleClueInput)),
      ),
    );
  }
}
