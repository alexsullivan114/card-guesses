import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Round.g.dart';

@JsonSerializable(nullable: true)
class Round {
  final Team teamUp;
  final Clue clue;

  Round(this.teamUp, this.clue);

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);

  Map<String, dynamic> toJson() => _$RoundToJson(this);
}
