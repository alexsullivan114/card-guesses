import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_my_cards/models/Clue.dart';

class ClueInput extends StatefulWidget {
  final void Function(Clue) _handleClueInput;

  ClueInput(this._handleClueInput);

  @override
  _ClueInputState createState() => _ClueInputState(_handleClueInput);
}

class _ClueInputState extends State<ClueInput> {
  String clueString = "";
  String guessCountString = "";
  final void Function(Clue) _handleClueInput;

  _ClueInputState(this._handleClueInput);

  void _submitClue() async {
    final guessCount = int.parse(guessCountString);
    final clue = Clue(clueString, guessCount);
    _handleClueInput(clue);
  }

  @override
  Widget build(BuildContext context) {
    final enableFab = clueString.isNotEmpty && guessCountString.isNotEmpty;
    final fabColor = enableFab ? Colors.blue : Colors.grey;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
            flex: 2,
            child: TextField(
              onChanged: (text) => setState(() => clueString = text),
              decoration: InputDecoration(
                helperText: "Clue",
                border: OutlineInputBorder(),
              ),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            onChanged: (text) => setState(() => guessCountString = text),
            inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
            decoration: InputDecoration(
              helperText: "Guesses",
              border: OutlineInputBorder(),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 5.0),
          child: FloatingActionButton(
            mini: true,
            backgroundColor: fabColor,
            child: Icon(Icons.done),
            onPressed: enableFab ? _submitClue : null,
          ),
        )
      ],
    );
  }
}
