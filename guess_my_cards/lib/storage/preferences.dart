import 'package:guess_my_cards/models/GameCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveGameCode(GameCode code) async {
  final preferences = await SharedPreferences.getInstance();
  preferences.setString("gameCode", code.code);
}

Future<GameCode> getGameCode() async {
  final preferences = await SharedPreferences.getInstance();
  final code = preferences.getString("gameCode");
  return GameCode(code: code);
}
