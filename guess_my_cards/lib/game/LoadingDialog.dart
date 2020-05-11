import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/api/API.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Guess.dart';
import 'package:guess_my_cards/models/Team.dart';

class LoadingDialog extends StatefulWidget {
  final String _message;
  final String _loadingMessage;
  final String _confirmationMessage;
  final Future<void> Function() _onConfirm;

  LoadingDialog(this._message, this._loadingMessage,
      this._confirmationMessage, this._onConfirm);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {

  var loading = false;

  @override
  Widget build(BuildContext context) {
    final content = loading ? Center(widthFactor: 1.0, heightFactor: 1.0,
        child: Wrap(children: [CircularProgressIndicator()])) : Text(
        widget._message);
    final text = loading ? widget._loadingMessage : widget
        ._confirmationMessage;
    final actions = loading ? <Widget>[] : [
      FlatButton(child: Text("No"), onPressed: () {
        Navigator.of(context).pop();
      },),
      FlatButton(
          child: Text("Yes"), onPressed: () async {
        setState(() {
          loading = true;
        });
        await widget._onConfirm();
        Navigator.of(context).pop();
      })
    ];
    return AlertDialog(title: Text(text),
        content: content,
        actions: actions);
  }
}
