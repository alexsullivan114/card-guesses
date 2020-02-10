import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'WordCard.dart';

class BoardRoute extends StatelessWidget {
  final Game game;

  BoardRoute(this.game);

  @override
  Widget build(BuildContext context) {
    final widgets = game.words.map((word) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: WordCard(word.text),
      );
    }).toList();

    return Scaffold(
      body: SlidingUpPanel(
        collapsed: Center(child: Text("Game code")),
        panel: Center(
            child: Text("${game.gameCode.code}",
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold))),
        body: Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 0.7,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
