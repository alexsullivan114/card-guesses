import 'package:flutter/material.dart';
import 'package:guess_my_cards/game/Board.dart';
import 'package:guess_my_cards/setup/CodeInputRoute.dart';

import 'setup/CreateGameRoute.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: CreateGameRoute()),
    );
  }
}
