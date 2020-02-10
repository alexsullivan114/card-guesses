import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/storage/preferences.dart';

import 'SelectTeamRoute.dart';

class CreateGameRoute extends StatefulWidget {
  @override
  _CreateGameRouteState createState() => _CreateGameRouteState();
}

class _CreateGameRouteState extends State<CreateGameRoute> {
  var loading = false;
  final textController = TextEditingController();

  void handleCreateGamePressed() async {
    setState(() {
      loading = true;
    });
    final createGameResult = await createGame();
    setState(() {
      loading = false;
    });
    if (createGameResult.isSuccess()) {
      await saveGameCode(createGameResult.data);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SelectTeamRoute()));
    }
  }

  void handleSubmit(String text) async {
    setState(() {
      loading = true;
    });

    final code = GameCode(code: text);
    await saveGameCode(code);
    final gameResult = await getGame(code);

    setState(() {
      loading = false;
    });

    if (gameResult.isSuccess()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SelectTeamRoute()));
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextField(
                  onSubmitted: handleSubmit,
                  controller: textController,
                  textInputAction: TextInputAction.done,
                  maxLength: 4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    helperText: "Input game code",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(child: Text("-- OR -- ")),
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: handleCreateGamePressed,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Create a new game"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Visibility(
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    visible: loading,
                    child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
