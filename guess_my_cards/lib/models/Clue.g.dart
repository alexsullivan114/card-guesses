// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Clue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clue _$ClueFromJson(Map<String, dynamic> json) {
  return Clue(
    json['text'] as String,
    json['guessesLeft'] as int,
  );
}

Map<String, dynamic> _$ClueToJson(Clue instance) => <String, dynamic>{
      'text': instance.text,
      'guessesLeft': instance.guessesLeft,
    };
