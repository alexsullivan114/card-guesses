import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Team.dart';
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

Future<void> setTeam(Team team) async {
  final preferences = await SharedPreferences.getInstance();
  preferences.setString("team", team.toString());
}

Future<Team> getTeam() async {
  final preferences = await SharedPreferences.getInstance();
  final team = await preferences.getString("team");
  return team == "Red" ? Team.Red : Team.Blue;
}
