import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_state_model.dart';

class GameStateDataBase {
  // String key = "gameStateKey";
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setGameState(SudokuStateModel sudoku) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(sudoku.gameType.name, sudoku.toString());
  }

  Future<SudokuStateModel?> getGameState({required String gameType}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(gameType);

    if (data == null) {
      return null;
    }
    // log(data);
    return data as SudokuStateModel;
    // return ProfileModel.fromJson(json.decode(data));
  }
}
