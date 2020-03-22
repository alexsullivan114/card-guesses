import 'dart:convert';
import 'dart:io';

import 'package:guess_my_cards/models/Clue.dart';
import 'package:guess_my_cards/models/Game.dart';
import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Guess.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'Either.dart';

// final coreApi = Platform.isIOS ? "localhost:8080" : "10.0.2.2:8080";
final coreApi = "pacific-lowlands-78447.herokuapp.com/";
// final baseApi = "http://$coreApi";
final baseApi = "https://$coreApi";

Stream<Game> gameStream(GameCode code) {
  final channel =
      IOWebSocketChannel.connect('ws://$coreApi/game/${code.code}/socket');

  return channel.stream.map((data) => Game.fromJson(jsonDecode(data)));
}

Future<NetworkResponse<dynamic, GameCode>> createGame() async {
  final response = await http.post('$baseApi/game');
  return response.wrappedResponse((map) => GameCode.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> getGame(GameCode code) async {
  final response = await http.get('$baseApi/game/${code.code}');
  return response.wrappedResponse((map) => Game.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> postGuess(
    Guess guess, GameCode code) async {
  final body = jsonEncode(guess.toJson());
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final response = await http.post('$baseApi/game/${code.code}/guess',
      headers: headers, body: body);
  return response.wrappedResponse((map) => Game.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> postClue(
    Clue clue, GameCode code) async {
  final body = jsonEncode(clue.toJson());
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final response = await http.post('$baseApi/game/${code.code}/clue',
      headers: headers, body: body);
  return response.wrappedResponse((map) => Game.fromJson(map));
}

extension ResponseExtension on Response {
  get success => statusCode >= 200 && statusCode < 300;

  NetworkResponse<String, T> wrappedResponse<T>(
      T Function(Map<String, dynamic>) objectCreator) {
    if (success) {
      return NetworkResponse.data(objectCreator(jsonDecode(body)), statusCode);
    } else {
      return NetworkResponse.error(body, statusCode);
    }
  }
}
