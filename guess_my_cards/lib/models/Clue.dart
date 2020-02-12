import 'package:json_annotation/json_annotation.dart';

part 'Clue.g.dart';

@JsonSerializable(nullable: false)
class Clue {
  final String text;
  final int guessesLeft;

  Clue(this.text, this.guessesLeft);

  factory Clue.fromJson(Map<String, dynamic> json) => _$ClueFromJson(json);

  Map<String, dynamic> toJson() => _$ClueToJson(this);
}
