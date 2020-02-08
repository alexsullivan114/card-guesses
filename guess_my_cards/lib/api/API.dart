import 'dart:convert';

import 'package:guess_my_cards/models/GameCode.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Either.dart';

const baseApi = "http://localhost:8080";

Future<NetworkResponse<dynamic, GameCode>> createGame() async {
  final response = await http.post('$baseApi/createGame');
  return response.wrappedResponse((map) => GameCode.fromJson(map));
}

extension ResponseExtension on Response {
  get success => statusCode >= 200 && statusCode < 300;

  NetworkResponse<String, T> wrappedResponse<T>(
      T Function(Map<String, dynamic>) objectCreator) {
    if (success) {
      return NetworkResponse.data(objectCreator(jsonDecode(body)));
    } else {
      return NetworkResponse.error(body);
    }
  }
}
