import 'package:guess_my_cards/models/GameCode.dart';
import 'package:guess_my_cards/models/Role.dart';
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
  preferences.setInt("team", team.index);
}

Future<Team> getTeam() async {
  final preferences = await SharedPreferences.getInstance();
  final team = await preferences.getInt("team");
  return team == 0 ? Team.Red : Team.Blue;
}

Future<void> setRole(Role role) async {
  final preferences = await SharedPreferences.getInstance();
  preferences.setInt("role", role.index);
}

Future<Role> getRole() async {
  final preferences = await SharedPreferences.getInstance();
  final roll = await preferences.getInt("role");
  return roll == 0 ? Role.Master : Role.Guesser;
}
