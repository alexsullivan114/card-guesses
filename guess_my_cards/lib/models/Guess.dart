import 'package:json_annotation/json_annotation.dart';

import 'Team.dart';

part 'Guess.g.dart';

@JsonSerializable()
class Guess {
  final String text;
  final Team team;

  Guess(this.text, this.team);

  factory Guess.fromJson(Map<String, dynamic> json) => _$GuessFromJson(json);

  Map<String, dynamic> toJson() => _$GuessToJson(this);
}
