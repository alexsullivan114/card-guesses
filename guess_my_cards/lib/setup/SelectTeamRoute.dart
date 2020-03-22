import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/game/BoardRoute.dart';
import 'package:guess_my_cards/models/Role.dart';
import 'package:guess_my_cards/models/Team.dart';
import 'package:guess_my_cards/setup/TeamSelector.dart';
import 'package:guess_my_cards/storage/preferences.dart';

class SelectTeamRoute extends StatefulWidget {
  @override
  _SelectTeamRouteState createState() => _SelectTeamRouteState();
}

class _SelectTeamRouteState extends State<SelectTeamRoute> {
  Team selectedTeam = Team.Red;
  Role selectedRole = Role.Guesser;

  void _handleFabPressed() async {
    await setTeam(selectedTeam);
    await setRole(selectedRole);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BoardRoute()),
        (Route<dynamic> route) => false);
  }

  void _handleTeamPressed(Team team) {
    setState(() {
      selectedTeam = team;
    });
  }

  void _handleRolePressed(Role role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.done),
            onPressed: _handleFabPressed,
          ),
          body: Column(
            children: <Widget>[
              Spacer(),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("What's your team and role?",
                    style: TextStyle(fontSize: 22)),
              )),
              Center(child: _teamSelector()),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Center(child: _roleSelector()),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamSelector() {
    return TeamSelector(
        Team.Red.name,
        Team.Red.color,
        () => _handleTeamPressed(Team.Red),
        Team.Blue.name,
        Team.Blue.color,
        () => _handleTeamPressed(Team.Blue),
        selectedTeam == Team.Red,
        selectedTeam == Team.Blue);
  }

  Widget _roleSelector() {
    return TeamSelector(
        Role.Master.name,
        selectedTeam.color,
        () => _handleRolePressed(Role.Master),
        Role.Guesser.name,
        selectedTeam.color,
        () => _handleRolePressed(Role.Guesser),
        selectedRole == Role.Master,
        selectedRole == Role.Guesser);
  }
}
