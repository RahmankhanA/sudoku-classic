import 'dart:async';

import 'package:get/get.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';



class GameController extends GetxController {

  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;
  var colSelected=-1.obs;
  var rowSelected=-1.obs;
  late List<List<int>> puzzle ;
  generateSudoku({emptySpace}){
  var sudokugenerator = SudokuGenerator(emptySquares: emptySpace);

  puzzle = sudokugenerator.newSudoku;
 update();

  }

@override
  void onInit() {
    generateSudoku(emptySpace: 27);
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
}
