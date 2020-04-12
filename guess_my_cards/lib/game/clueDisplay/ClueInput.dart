import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_my_cards/models/Clue.dart';

class ClueInput extends StatefulWidget {
  final void Function(Clue) _handleClueInput;
  final bool _loading;

  ClueInput(this._handleClueInput, this._loading);

  @override
  _ClueInputState createState() => _ClueInputState();
}

class _ClueInputState extends State<ClueInput> {
  String clueString = "";
  String guessCountString = "";

  void _submitClue() async {
    final guessCount = int.parse(guessCountString);
    final clue = Clue(clueString, guessCount);
    widget._handleClueInput(clue);
  }

  @override
  Widget build(BuildContext context) {
    final button = widget._loading ? CircularProgressIndicator() : _button();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
            flex: 2,
            child: TextField(
              onChanged: (text) => setState(() => clueString = text),
              inputFormatters: [
                BlacklistingTextInputFormatter(" ")
              ],
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
          child: button
        )
      ],
    );
  }

  Widget _button() {
    final enableFab = clueString.isNotEmpty && guessCountString.isNotEmpty;
    final fabColor = enableFab ? Colors.blue : Colors.grey;
    return FloatingActionButton(
      mini: true,
      backgroundColor: fabColor,
      child: Icon(Icons.done),
      onPressed: enableFab ? _submitClue : null,
    );
  }
}
