import 'package:guess_my_cards/models/GameCode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Game.g.dart';

@JsonSerializable(nullable: false)
class Game {
  final GameCode gameCode;
  final List<Word> words;
  final GameStatus status;

  Game(this.gameCode, this.words, this.status);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @override
  String toString() {
    return 'Game{gameCode: $gameCode, words: $words, status: $status}';
  }
}

@JsonSerializable(nullable: false)
class Word {
  final String text;
  final CardOwner owner;
  final GuessStatus guessStatus;

  Word(this.text, this.owner, this.guessStatus);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  @override
  String toString() {
    return 'Word{text: $text, owner: $owner, guessStatus: $guessStatus}';
  }
}

enum CardOwner { Red, Blue, Unowned, Assassin }

enum GuessStatus { Guessed, NotGuessed }

enum GameStatus { BlueWon, BedWon, Playing }
