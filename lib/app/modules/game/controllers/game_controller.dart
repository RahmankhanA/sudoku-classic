import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_model.dart';
import 'package:sudoku_classic/app/modules/game/service/sudoku_service.dart';
import 'package:sudoku_classic/app/modules/game/widgets/alert.dart';

class GameController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  RxInt lifeRemain = 5.obs;
  final time = '00.00'.obs;
  var colSelected = -1.obs;
  var rowSelected = -1.obs;
  int selectedNumber = -1;
  List<int> remainingNumberCount = [];
  late List<List<SudokuModel>> puzzle;
  late List<List<int>> userInput;
  late SudokuGenerator sudokuGenerator;
  List<Map<String, int>> hint = [];

  generateSudoku({emptySpace}) {
    hint.clear();
    lifeRemain.value = 5;
    _startTimer(0);
    remainingNumberCount = [9, 9, 9, 9, 9, 9, 9, 9, 9];
    userInput = List.generate(9, (index) => List.generate(9, (index) => -1));
    sudokuGenerator = SudokuGenerator(emptySquares: emptySpace);

    puzzle = sudokuGenerator.newSudoku;
    // for (int row = 0; row < 10; row++) {
    //   for (int col = 0; col < 10; col++) {}
    // }

    for (List<SudokuModel> row in puzzle) {
      for (SudokuModel i in row) {
        if (i.value == 0) {
          continue;
        }
        remainingNumberCount[i.value - 1]--;
      }
    }
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (puzzle[i][j].value == 0) {
          hint.add({'$i $j': sudokuGenerator.newSudokuSolved[i][j].value});
        }
      }
    }

    

    update();
  }

  @override
  void onInit() {
    generateSudoku(emptySpace: 5);
    super.onInit();
  }

  @override
  void onReady() {
    _startTimer(0);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      int minutes = remainingSeconds ~/ 60;
      int seconds = (remainingSeconds % 60);
      time.value =
          "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
      remainingSeconds++;
    });
  }

  fillNextHint() {
    if (hint.isNotEmpty) {
      Map<String, int> firstHint = hint.first;

      List<String> data = firstHint.keys.first.split(" ");
      int data2 = firstHint.values.first;
      puzzle[int.parse(data[0])][int.parse(data[1])].value = data2;
      hint.remove(firstHint);

      remainingNumberCount[data2 - 1]--;

      if (sudokuGenerator.newSudoku == sudokuGenerator.newSudokuSolved) {
        CustomAlert.gameWon(controller: this);
      }
      update();
    }
  }

  void onPressedDeleteIcon() {
    if (rowSelected > -1) {
      if (puzzle[rowSelected][colSelected].isEditable) {
        int currentValue = puzzle[rowSelected][colSelected].value;
        if (currentValue != 0) {
          remainingNumberCount[puzzle[rowSelected][colSelected].value - 1]++;
        }
        puzzle[rowSelected][colSelected].value = 0;
        update();
      }
    }
  }

  void onPressedNumber({required int value}) {
    bool isNumberAvailable = remainingNumberCount[value - 1] != 0;
    // bool isPositionEditable =
    //     (sudokuGenerator.newSudoku[rowSelected][colSelected] == 0 ||
    //         userInput[rowSelected][colSelected] != 0);

    if (rowSelected > -1) {
      if (isNumberAvailable && puzzle[rowSelected][colSelected].isEditable) {
        int currentValue = puzzle[rowSelected][colSelected].value;
        if (currentValue != 0) {
          remainingNumberCount[puzzle[rowSelected][colSelected].value - 1]++;
        }
        if (!sudokuGenerator.checkIfSafe(rowSelected, colSelected, value)) {
          puzzle[rowSelected][colSelected].isValid = false;
          if (lifeRemain.value < 1) {
            CustomAlert.gameOver(controller: this);
          } else {
            lifeRemain.value--;
            CustomAlert.showWrongInputDialog(life: lifeRemain.value);
          }
        } else {
          puzzle[rowSelected][colSelected].isValid = true;
        }

        puzzle[rowSelected][colSelected].value = value;

        //  int index=-1;
        hint.removeAt(
            hint.indexWhere((element) => element.values.first == value));

        remainingNumberCount[value - 1]--;
        log((sudokuGenerator.newSudoku == sudokuGenerator.newSudokuSolved)
            .toString());
        if (sudokuGenerator.newSudoku == sudokuGenerator.newSudokuSolved) {
          CustomAlert.gameWon(controller: this);
        }
        log(puzzle[rowSelected][colSelected].toString());
        update();
      } else {
        log(sudokuGenerator.newSudoku[rowSelected][colSelected].toString());
      }
    }
  }
}
