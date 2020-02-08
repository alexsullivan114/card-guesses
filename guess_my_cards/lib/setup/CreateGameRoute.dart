import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/game/Board.dart';

class CreateGameRoute extends StatefulWidget {
  @override
  _CreateGameRouteState createState() => _CreateGameRouteState();
}

class _CreateGameRouteState extends State<CreateGameRoute> {
  bool loading = false;

  void handleCreateGamePressed() async {
    setState(() {
      loading = true;
    });
    final result = await createGame();
    setState(() {
      loading = false;
    });
    if (result.isSuccess()) {
      print("Result: ${result.data.code}");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Board()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            color: Colors.red,
            onPressed: handleCreateGamePressed,
            child: Text("Create a new game"),
          ),
          Visibility(
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              visible: loading,
              child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
