// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) {
  return Round(
    _$enumDecodeNullable(_$TeamEnumMap, json['teamUp']),
    json['clue'] == null
        ? null
        : Clue.fromJson(json['clue'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'teamUp': _$TeamEnumMap[instance.teamUp],
      'clue': instance.clue,
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
