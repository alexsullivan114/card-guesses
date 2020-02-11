// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Guess.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guess _$GuessFromJson(Map<String, dynamic> json) {
  return Guess(
    json['text'] as String,
    _$enumDecodeNullable(_$TeamEnumMap, json['team']),
  );
}

Map<String, dynamic> _$GuessToJson(Guess instance) => <String, dynamic>{
      'text': instance.text,
      'team': _$TeamEnumMap[instance.team],
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

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TeamEnumMap = {
  Team.Red: 'Red',
  Team.Blue: 'Blue',
};
