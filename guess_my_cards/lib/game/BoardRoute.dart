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
  Team team;
  Role role;
  GameCode code;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  void _loadState() async {
    final team = await getTeam();
    final role = await getRole();
    final code = await getGameCode();
    setState(() {
      this.code = code;
      this.role = role;
      this.team = team;
    });
  }

  void _handleWordPressed(Word word) async {
    final guess = Guess(word.text, team);
    await postGuess(guess, code);
  }

  void _handleClueInput(Clue clue) async {
    await postClue(clue, code);
  }

  @override
  Widget build(BuildContext context) {
    final loadingIndicator = Center(child: CircularProgressIndicator());
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: code == null
                ? loadingIndicator
                : StreamBuilder<Game>(
                    stream: gameStream(code),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Board(snapshot.data, role, team,
                            _handleWordPressed, _handleClueInput);
                      } else {
                        return loadingIndicator;
                      }
                    })),
      ),
    );
  }
}
