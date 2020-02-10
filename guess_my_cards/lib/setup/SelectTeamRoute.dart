import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/game/Board.dart';
import 'package:guess_my_cards/models/Team.dart';
import 'package:guess_my_cards/storage/preferences.dart';

class SelectTeamRoute extends StatelessWidget {
  void handleTeamPressed(Team team, BuildContext context) async {
    await setTeam(team);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Board()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("What team are you on?"),
              )),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: _teamButton(Team.Red, context)),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: _teamButton(Team.Blue, context)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamButton(Team team, BuildContext context) {
    final color = team == Team.Blue ? Colors.blue : Colors.red;
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: color)),
      child: Text(
        "${team.toString()} Team",
        style: TextStyle(color: color),
      ),
      onPressed: () => handleTeamPressed(team, context),
    );
  }
}
