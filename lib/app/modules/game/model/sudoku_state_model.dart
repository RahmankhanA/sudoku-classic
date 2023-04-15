// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_model.dart';

enum GameDeficultyLevel { Easy, Medium, Hard, Expert ,}

class SudokuStateModel {
  final GameDeficultyLevel gameType;
  final int level;
  final List<List<SudokuModel>> puzzle;
  final List<List<SudokuModel>> solution;
  final List<Map<String, int>> hintList;
  final int remainingLife;
  final String time;
  final List<int> numberCount;

  SudokuStateModel({
    required this.gameType,
    required this.level,
    required this.puzzle,
    required this.solution,
    required this.hintList,
    required this.remainingLife,
    required this.time,
    required this.numberCount,
  });

  @override
  String toString() {
    return 'SudokuStateModel(gameType: $gameType, level: $level, puzzle: $puzzle, solution: $solution, hintList: $hintList, remainingLife: $remainingLife, time: $time, numberCount: $numberCount)';
  }

  SudokuStateModel copyWith({
    GameDeficultyLevel? gameType,
    int? level,
    List<List<SudokuModel>>? puzzle,
    List<List<SudokuModel>>? solution,
    List<Map<String, int>>? hintList,
    int? remainingLife,
    String? time,
    List<int>? numberCount,
  }) {
    return SudokuStateModel(
      gameType: gameType ?? this.gameType,
      level: level ?? this.level,
      puzzle: puzzle ?? this.puzzle,
      solution: solution ?? this.solution,
      hintList: hintList ?? this.hintList,
      remainingLife: remainingLife ?? this.remainingLife,
      time: time ?? this.time,
      numberCount: numberCount ?? this.numberCount,
    );
  }

  @override
  bool operator ==(covariant SudokuStateModel other) {
    if (identical(this, other)) return true;

    return other.gameType == gameType &&
        other.level == level &&
        listEquals(other.puzzle, puzzle) &&
        listEquals(other.solution, solution) &&
        listEquals(other.hintList, hintList) &&
        other.remainingLife == remainingLife &&
        other.time == time &&
        listEquals(other.numberCount, numberCount);
  }

  @override
  int get hashCode {
    return gameType.hashCode ^
        level.hashCode ^
        puzzle.hashCode ^
        solution.hashCode ^
        hintList.hashCode ^
        remainingLife.hashCode ^
        time.hashCode ^
        numberCount.hashCode;
  }
}
