import 'package:flutter/material.dart';

enum Team { Red, Blue }

extension TeamUtils on Team {
  get color => this == Team.Red ? Colors.red : Colors.blue;
  get name => this == Team.Red ? "Red" : "Blue";
  get otherTeam => this == Team.Red ? Team.Blue : Team.Red;
}
