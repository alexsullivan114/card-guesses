import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeamSelector extends StatelessWidget {
  final String _leftText;
  final Color _leftBorderColor;
  final VoidCallback _leftButtonCallback;
  final bool _leftSelected;
  final String _rightText;
  final Color _rightBorderColor;
  final VoidCallback _rightButtonCallback;
  final bool _rightSelected;

  TeamSelector(
      this._leftText,
      this._leftBorderColor,
      this._leftButtonCallback,
      this._rightText,
      this._rightBorderColor,
      this._rightButtonCallback,
      this._leftSelected,
      this._rightSelected);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: <Widget>[_selectableItem(true), _selectableItem(false)],
      ),
    );
  }

  Widget _selectableItem(bool isLeft) {
    final text = isLeft ? _leftText : _rightText;
    final color = isLeft ? _leftBorderColor : _rightBorderColor;
    final VoidCallback callback =
        isLeft ? _leftButtonCallback : _rightButtonCallback;
    Color fillColor = null;
    Color textColor = color;
    if (isLeft && _leftSelected || !isLeft && _rightSelected) {
      fillColor = isLeft ? _leftBorderColor : _rightBorderColor;
      textColor = Colors.white;
    }

    return Expanded(
      child: Container(
        height: 60,
        decoration:
            BoxDecoration(border: Border.all(color: color), color: fillColor),
        child: InkWell(
          child: Center(
              child: Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textColor))),
          onTap: callback,
        ),
      ),
    );
  }
}
