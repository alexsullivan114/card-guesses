import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/game/GameOverOverlay.dart';
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
  Team team;
  Role role;
  GameCode code;
  Game game;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  void _loadState() async {
    final team = await getTeam();
    final role = await getRole();
    final code = await getGameCode();
    final gameResponse = await getGame(code);
    print("Team: ${team.name}");
    setState(() {
      this.code = code;
      this.role = role;
      this.team = team;
      if (gameResponse.isSuccess()) {
        this.game = gameResponse.data;
      }
      _observeGameStream();
    });
  }

  void _observeGameStream() async {
    final stream = gameStream(code);
    await for (var newGame in stream) {
      setState(() {
        this.game = newGame;
      });
    }
  }

  void _handleWordPressed(Word word) async {
    if (role != Role.Master) {
      final guess = Guess(word.text, team);
      await postGuess(guess, code);
    }
  }

  void _handleClueInput(Clue clue) async {
    await postClue(clue, code);
  }

  Team _winningTeam() {
    Team winningTeam;
    switch (game?.status) {
      case GameStatus.BlueWon:
        winningTeam = Team.Blue;
        break;
      case GameStatus.RedWon:
        winningTeam = Team.Red;
        break;
      default:
        winningTeam = null;
        break;
    }

    return winningTeam;
  }

  @override
  Widget build(BuildContext context) {
    final loadingIndicator = Center(child: CircularProgressIndicator());
    final Team winningTeam = _winningTeam();
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SafeArea(
              child: Scaffold(
                body: game == null
                    ? loadingIndicator
                    : Board(
                        game, role, team, _handleWordPressed, _handleClueInput),
              )),
          if (winningTeam != null) GameOverOverlay(winningTeam),
        ],
      ),
    );
  }
}
