import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_model.dart';
import 'package:sudoku_classic/app/modules/game/service/sudoku_service.dart';
import 'package:sudoku_classic/app/modules/game/widgets/alert.dart';

class GameController extends GetxController {
  // for showing the timer
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;

// for showing the remaining chance
  RxInt lifeRemain = 5.obs;

  // to highlight the selected row and column
  var colSelected = -1.obs;
  var rowSelected = -1.obs;

// to store the number count that are available to fill in the puzzle board
  List<int> remainingNumberCount = [];

  // to store the puzzle board
  late List<List<SudokuModel>> puzzle;

// creating sudoku ggenerator
  late SudokuGenerator sudokuGenerator;

// to store the hint | tips | next Move
  List<Map<String, int>> hint = [];

  generateSudoku({required int emptySpace}) {
    // clearing the hint list
    hint.clear();

    // initilizing life
    lifeRemain.value = 5;

    // starting timer
    _startTimer(0);

    // initializing number count
    remainingNumberCount = [9, 9, 9, 9, 9, 9, 9, 9, 9];

    // generating sudoku board
    sudokuGenerator = SudokuGenerator(emptySquares: emptySpace);

    puzzle = sudokuGenerator.newSudoku;

    // calculating remaining number count
    calculateRemaningNumberCount();

    // creating list of all available hint
    creatingHint();

    // updating ui
    update();
  }

  @override
  void onInit() {
    // creating initial sudoku
    generateSudoku(emptySpace: 18);
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
    // creating duration of 1 second
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
    //checking that hint is available or not
    if (hint.isNotEmpty) {
      // fetching first hint
      Map<String, int> firstHint = hint.first;

      // creating a list of row and col from first hint key
      List<String> data = firstHint.keys.first.split(" ");

      // extracting value from first hint
      int data2 = firstHint.values.first;

      // adding hint in the puzzle board
      puzzle[int.parse(data[0])][int.parse(data[1])].value = data2;

      // removing first hint from hint list
      hint.remove(firstHint);

      // decreasing the remaining number count
      remainingNumberCount[data2 - 1]--;

      // checking that sudoku is solved or not
      bool res = isPuzzleSolved(
          puzzleBoard: puzzle, solution: sudokuGenerator.newSudokuSolved);
      if (res) {
        // showing the solved puzzle alert
        CustomAlert.gameWon(controller: this);
      }
      // updating the UI
      update();
    }
  }

  void onPressedDeleteIcon() {
    // checking that any cell is selected or not and if selected the is current cell editable or not
    if (rowSelected > -1 && puzzle[rowSelected][colSelected].isEditable) {
      // fetching the value of selected cell
      int currentValue = puzzle[rowSelected][colSelected].value;

      // checking that value of selected cell is 0 or not
      if (currentValue != 0) {
        //increasing the remaining number count
        remainingNumberCount[puzzle[rowSelected][colSelected].value - 1]++;

        // filling the selected cell with zero
        puzzle[rowSelected][colSelected].value = 0;

        // updating UI
        update();
      }
    }
  }

  void onPressedNumber({required int value}) {
    bool isNumberAvailable = remainingNumberCount[value - 1] != 0;
    // checking that any cell is selected or not AND is selected cell editable or not AND Pressed Number is available or not
    if (rowSelected > -1 &&
        puzzle[rowSelected][colSelected].isEditable &&
        isNumberAvailable) {
      // extracting the current value of selected cell
      int currentValue = puzzle[rowSelected][colSelected].value;

      // checking that selected cell is filled with any number or empty
      if (currentValue != 0) {
        //increasing the remaining number count
        remainingNumberCount[puzzle[rowSelected][colSelected].value - 1]++;
      }

      // checking that move is valid or not
      moveCheck(
        row: rowSelected,
        column: colSelected,
        life: lifeRemain,
        value: value,
      );

      // for removing hint from the hint list
      removeHint(row: rowSelected, column: colSelected);

      // decreasing the remaining number count
      remainingNumberCount[value - 1]--;

      log((sudokuGenerator.newSudoku == sudokuGenerator.newSudokuSolved)
          .toString());

      // checking that is puzzle soved or not

      bool res = isPuzzleSolved(
          puzzleBoard: puzzle, solution: sudokuGenerator.newSudokuSolved);
      if (res) {
        // showing the solved puzzle alert
        CustomAlert.gameWon(controller: this);
      }

      log(puzzle[rowSelected][colSelected].toString());

      // updating UI
      update();
    }
  }

  void calculateRemaningNumberCount() {
    for (List<SudokuModel> row in puzzle) {
      for (SudokuModel i in row) {
        if (i.value == 0) {
          // checking that current cell is empty or not
          continue;
        }
        remainingNumberCount[i.value - 1]--;
      }
    }
  }

  void creatingHint() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        // checking that current cell is empty or not
        if (puzzle[i][j].value == 0) {
          // if current cell is empty then add that add that cell value from solved sudoku to hint
          hint.add({'$i $j': sudokuGenerator.newSudokuSolved[i][j].value});
        }
      }
    }
  }

  void removeHint({
    required int row,
    required int column,
  }) {
    hint.remove(
        hint.firstWhere((element) => element.keys.first == '$row $column'));
  }

  void moveCheck({
    required int row,
    required int column,
    required RxInt life,
    required int value,
  }) {
    // checking that pressed number is a valid solution or not
    if (sudokuGenerator.checkIfSafe(row, column, value)) {
      // making isValid true for the selected cell
      puzzle[row][column].isValid = true;
    } else {
      // making isValid false for the selected cell
      puzzle[row][column].isValid = false;

      // checking that life is available or not
      if (life.value == 0) {
        // showing the game over alert
        CustomAlert.gameOver(controller: this);
      } else {
        // decreasing the life
        life.value--;

        // showing the wrong input alert
        CustomAlert.showWrongInputDialog(life: lifeRemain.value);
      }
    }

    // updating the value of selected cell
    puzzle[rowSelected][colSelected].value = value;
  }

  bool isPuzzleSolved({
    required List<List<SudokuModel>> puzzleBoard,
    required List<List<SudokuModel>> solution,
  }) {
    // bool isSolved = true;
    for (int row = 0; row < 9; row++) {
      for (int column = 0; column < 9; column++) {
        if (puzzleBoard[row][column] != solution[row][column]) {
          return false;
        }
      }
    }
    log("unsolved");
    return true;
  }
}
