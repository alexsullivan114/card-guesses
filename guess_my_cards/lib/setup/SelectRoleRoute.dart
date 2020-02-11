import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/game/BoardRoute.dart';
import 'package:guess_my_cards/models/Role.dart';
import 'package:guess_my_cards/models/Team.dart';
import 'package:guess_my_cards/storage/preferences.dart';

class SelectRoleRoute extends StatelessWidget {
  void _handleRolePressed(Role role, BuildContext context) async {
    await setRole(role);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BoardRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
              future: getTeam(),
              builder: (BuildContext context, AsyncSnapshot<Team> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  final team = snapshot.data;
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
                              child: Text("What's your role?"),
                            )),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child:
                                      _roleButton(team, Role.Master, context)),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child:
                                      _roleButton(team, Role.Guesser, context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget _roleButton(Team team, Role role, BuildContext context) {
    final color = team == Team.Blue ? Colors.blue : Colors.red;
    final text = role == Role.Master ? "Master" : "Guesser";
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: color)),
      child: Text(
        "${text}",
        style: TextStyle(color: color),
      ),
      onPressed: () => _handleRolePressed(role, context),
    );
  }
}
