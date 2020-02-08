import 'package:json_annotation/json_annotation.dart';

part 'GameCode.g.dart';

@JsonSerializable(nullable: false)
class GameCode {
  final String code;

  GameCode({this.code});

  factory GameCode.fromJson(Map<String, dynamic> json) =>
      _$GameCodeFromJson(json);

  Map<String, dynamic> toJson() => _$GameCodeToJson(this);
}
