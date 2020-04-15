import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Guess.dart';
import 'package:guess_my_cards/models/Team.dart';

class GuessWordConfirmationDialog extends StatefulWidget {
  final Word _word;
  final Team _team;
  final GameCode _code;

  GuessWordConfirmationDialog(this._word, this._team, this._code);

  @override
  _GuessWordConfirmationDialogState createState() => _GuessWordConfirmationDialogState();
}

class _GuessWordConfirmationDialogState
    extends State<GuessWordConfirmationDialog> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    final content = loading ? Center(widthFactor: 1.0, heightFactor: 1.0,
        child: Wrap(children: [CircularProgressIndicator()])) : Text(
        "Do you rrreeaalllllyyy want to guess ${widget._word.text}");
    final text = loading ? "Guessing..." : "Are you sure?";
    final actions = loading ? <Widget>[] : [
      FlatButton(child: Text("No"), onPressed: () {
        Navigator.of(context).pop();
      },),
      FlatButton(
          child: Text("Yes"), onPressed: () async {
        final guess = Guess(widget._word.text, widget._team);
        setState(() {
          loading = true;
        });
        await postGuess(guess, widget._code);
        Navigator.of(context).pop();
      })
    ];
    return AlertDialog(title: Text(text),
        content: content,
        actions: actions);
  }
}
