import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_my_cards/WordCard.dart';

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = [
      "Apple",
      "Orange",
      "Grape",
      "Plum",
      "Date",
      "Grapefruit",
      "Banana",
      "Rukh",
      "Tree",
      "Kukur",
      "Khasto",
      "Khao",
      "Flight",
      "America",
      "Super",
      "Powers",
      "Wood",
      "Phone",
      "Black",
      "Outlet",
      "Grain",
      "Globe",
      "Loud",
      "Itchy",
      "Dusty",
    ];

    final widgets = strings.map((string){
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: WordCard(string),
      );
    }).toList();

    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: 0.7,
        children: widgets,
      ),
    );
  }
}
