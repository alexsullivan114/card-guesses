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

final prodCoreApi = "pacific-lowlands-78447.herokuapp.com/";
final prodBaseApi = "https://$prodCoreApi";
final devCoreApi = Platform.isIOS ? "localhost:8080" : "10.0.2.2:8080";
final devBaseApi = "http://$devCoreApi";

final coreApi = prodCoreApi;
final baseApi = prodBaseApi;

Stream<Game> gameStream(GameCode code) {
  final channel =
  IOWebSocketChannel.connect('ws://$coreApi/game/${code.code}/socket',
      pingInterval: Duration(seconds: 20));

  return channel.stream.map((data) => Game.fromJson(jsonDecode(data)));
}

Future<NetworkResponse<dynamic, GameCode>> createGame() async {
  return await http.post('$baseApi/game').executeRequest((map) => GameCode.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> getGame(GameCode code) async {
  return await http.get('$baseApi/game/${code.code}').executeRequest((map) =>
      Game.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> postGuess(
    Guess guess, GameCode code) async {
  final body = jsonEncode(guess.toJson());
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  return await http.post('$baseApi/game/${code.code}/guess',
      headers: headers, body: body).executeRequest((map) => Game.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> postClue(
    Clue clue, GameCode code) async {
  final body = jsonEncode(clue.toJson());
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  return await http.post('$baseApi/game/${code.code}/clue',
      headers: headers, body: body).executeRequest((map) => Game.fromJson(map));
}

Future<NetworkResponse<dynamic, Game>> postPass(GameCode code) async {
  final headers = {HttpHeaders.contentTypeHeader: "application/json"};
  return await http.post('$baseApi/game/${code.code}/pass',
      headers: headers).executeRequest((map) => Game.fromJson(map));
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

extension RequestExtension on Future<Response> {
  Future<NetworkResponse<dynamic, T>> executeRequest<T>(
      T Function(Map<String, dynamic>) objectCreator) async {
    try {
      final response = await this;
      return response.wrappedResponse(objectCreator);
    } catch (e) {
      return NetworkResponse.error(e, -1);
    }
  }
}
