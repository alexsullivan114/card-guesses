import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CodeInputRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          decoration: InputDecoration(labelText: "Enter your room code"),
        ),
      ),
    );
  }
}
