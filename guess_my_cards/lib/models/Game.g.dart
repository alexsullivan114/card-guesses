// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    GameCode.fromJson(json['gameCode'] as Map<String, dynamic>),
    (json['words'] as List)
        .map((e) => Word.fromJson(e as Map<String, dynamic>))
        .toList(),
    _$enumDecode(_$GameStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'gameCode': instance.gameCode,
      'words': instance.words,
      'status': _$GameStatusEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$GameStatusEnumMap = {
  GameStatus.BlueWon: 'BlueWon',
  GameStatus.BedWon: 'BedWon',
  GameStatus.Playing: 'Playing',
};

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
    json['text'] as String,
    _$enumDecode(_$CardOwnerEnumMap, json['owner']),
    _$enumDecode(_$GuessStatusEnumMap, json['guessStatus']),
  );
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'text': instance.text,
      'owner': _$CardOwnerEnumMap[instance.owner],
      'guessStatus': _$GuessStatusEnumMap[instance.guessStatus],
    };

const _$CardOwnerEnumMap = {
  CardOwner.Red: 'Red',
  CardOwner.Blue: 'Blue',
  CardOwner.Unowned: 'Unowned',
  CardOwner.Assassin: 'Assassin',
};

const _$GuessStatusEnumMap = {
  GuessStatus.Guessed: 'Guessed',
  GuessStatus.NotGuessed: 'NotGuessed',
};
