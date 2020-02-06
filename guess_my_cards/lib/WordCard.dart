import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WordCard extends StatelessWidget {
  final String text;

  WordCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.yellow.shade200),
      child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),)),
    );
  }
}
