import 'dart:async';
import 'dart:developer';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/controllers/ads_controller.dart';
import 'package:sudoku_classic/app/data/local_db/game_state_db.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_model.dart';
import 'package:sudoku_classic/app/modules/game/model/sudoku_state_model.dart';
import 'package:sudoku_classic/app/modules/game/service/sudoku_service.dart';
import 'package:sudoku_classic/app/modules/game/widgets/alert.dart';
import 'package:sudoku_classic/app/modules/profile/controllers/profile_controller.dart';

class GameController extends GetxController {
  GameStateDataBase gameStateDataBase = GameStateDataBase();
  ProfileController profileController = Get.find<ProfileController>();
  AdsController adsController = Get.find<AdsController>();

  // for showing the timer
  Timer? _timer;
  int remainingSeconds = 1;
  bool isTimerPaused = true;
  String time = '00.00';
  String gameType = '';
  late int currentLevel;

// for showing the remaining chance
  RxInt lifeRemain = 3.obs;

  // to highlight the selected row and column
  var colSelected = -1.obs;
  var rowSelected = -1.obs;

// to store the number count that are available to fill in the puzzle board
  List<int> remainingNumberCount = [];

  // to store the puzzle board
  late List<List<SudokuModel>> puzzle;
  late List<List<SudokuModel>> _solution;

// creating sudoku ggenerator
  late SudokuGenerator sudokuGenerator;

// to store the hint | tips | next Move
  List<Map<String, int>> hint = [];

  generateSudoku() async {
    adsController.numberOfGamePlayed++;

    // clearing the hint list
    hint.clear();

    // initilizing life
    lifeRemain.value = 3;

    int emptySpace = gameType == 'Easy'
        ? 18
        : gameType == 'Medium'
            ? 27
            : gameType == 'Hard'
                ? 36
                : 45;

    // initializing number count
    remainingNumberCount = [9, 9, 9, 9, 9, 9, 9, 9, 9];

    // generating sudoku board
    sudokuGenerator = SudokuGenerator(emptySquares: emptySpace);

    puzzle = sudokuGenerator.newSudoku;
    _solution = sudokuGenerator.newSudokuSolved;

    if (time != '00.00') {
      _timer!.cancel();
    }
    _startTimer(0);
    // calculating remaining number count
    calculateRemaningNumberCount();

    // creating list of all available hint
    creatingHint();

    // updating ui
    update();
    if (adsController.numberOfGamePlayed % 5 == 0 &&
        adsController.isInterstitialAdLoaded) {
      adsController.interstitialAd.show().then((value) {
        adsController.initializeFullPageAd();
      });
    }
    log("number of game played ${adsController.numberOfGamePlayed}");
  }

  @override
  void onInit() {
    // creating initial sudoku
    adsController.initializeHomePageBanner();
    adsController.createRewardedAd();
    adsController.initializeFullPageAd();
    gameType = Get.arguments['Type'];
    currentLevel = Get.arguments['gameLevel'];
    // gameStateDataBase.getGameState(gameType: gameType);
    // if (isSelectedGameTypePaused()) {
    //   getPausedLevel();
    //   // gameStateDataBase.getGameState(gameType: gameType);
    // } else {
      generateSudoku();
    // }

    super.onInit();
  }

  @override
  void onReady() {
    // CustomAlert.gameWon();
    super.onReady();
  }

  @override
  void onClose() {
    if (adsController.numberOfGamePlayed % 3 == 0 &&
        adsController.isInterstitialAdLoaded) {
      adsController.interstitialAd.show();
    }
    log('interstitial add loded ${adsController.isInterstitialAdLoaded}');
    updateUserProfileForLevelPaused();
    gameStateDataBase.setGameState(
      SudokuStateModel(
          gameType: getGameDeficultiLevel(),
          level: currentLevel,
          puzzle: puzzle,
          solution: _solution,
          hintList: hint,
          remainingLife: lifeRemain.value,
          time: time,
          numberCount: remainingNumberCount),
    );
    _timer!.cancel();
    super.onClose();
  }

  _startTimer(int seconds) {
    // creating duration of 1 second
    log(seconds.toString());
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    // isTimerPaused = false;
    _timer = Timer.periodic(duration, (Timer timer) {
      int minutes = remainingSeconds ~/ 60;
      int seconds = (remainingSeconds % 60);
      time =
          "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
      remainingSeconds++;
      update(['timer']);
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
      bool res = isPuzzleSolved(puzzleBoard: puzzle, solution: _solution);
      if (res) {
        increaseLevel();
        update(['level']);
        // showing the solved puzzle alert
        CustomAlert.gameWon(controller: this);
      }
      // updating the UI
      profileController.user = profileController.user.copyWith(
        // availableHint: 10,
        availableHint: profileController.user.availableHint - 1,
      );
      profileController.updateUserProfile(profileController.user);
    }
    profileController.update(['hint']);
    update();
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

      // checking that is puzzle soved or not

      bool res = isPuzzleSolved(puzzleBoard: puzzle, solution: _solution);
      if (res) {
        increaseLevel();
        // showing the solved puzzle alert
        update(['level']);
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
          hint.add({'$i $j': _solution[i][j].value});
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
      if (life.value == 1) {
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
    // log("unsolved");
    return true;
  }

  void increaseLevel() {
    switch (gameType) {
      case 'Easy':
        profileController.user = profileController.user.copyWith(
          currentEasyLevel: profileController.user.currentEasyLevel + 1,
          score: profileController.user.score + 10,
          // isMediumLevelActive:
          //     profileController.user.score > 100 ? true : false,
          // currentMediumLevel: profileController.user.score == 50
          //     ? 1
          //     : profileController.user.currentMediumLevel,
          // // isHardLevelActive: profileController.user.score > 200 ? true : false,
          // currentHardLevel: profileController.user.score == 100
          //     ? 1
          //     : profileController.user.currentHardLevel,
          // currentExpertLevel: profileController.user.score == 150
          //     ? 1
          //     : profileController.user.currentExpertLevel,
        );

        profileController.updateUserProfile(profileController.user);
        currentLevel = currentLevel + 1;
        break;
      case 'Medium':
        profileController.user = profileController.user.copyWith(
          currentMediumLevel: profileController.user.currentMediumLevel + 1,
          score: profileController.user.score + 10,
          // isHardLevelActive: profileController.user.score > 200 ? true : false,
          // currentHardLevel: profileController.user.score == 10
          //     ? 1
          //     : profileController.user.currentHardLevel,
          // currentExpertLevel: profileController.user.score == 150
          //     ? 1
          //     : profileController.user.currentExpertLevel,
        );

        profileController.updateUserProfile(profileController.user);
        currentLevel = currentLevel + 1;
        break;
      case 'Hard':
        profileController.user = profileController.user.copyWith(
          currentHardLevel: profileController.user.currentHardLevel + 1,
          score: profileController.user.score + 10,
          // currentExpertLevel: profileController.user.score == 150
          //     ? 1
          //     : profileController.user.currentExpertLevel,
        );

        profileController.updateUserProfile(profileController.user);
        currentLevel = currentLevel + 1;
        break;
      case 'Expert':
        profileController.user = profileController.user.copyWith(
          currentExpertLevel: profileController.user.currentExpertLevel + 1,
          score: profileController.user.score + 10,
        );

        profileController.updateUserProfile(profileController.user);
        currentLevel = currentLevel + 1;
        break;
      default:
    }
  }

  void pauseTimer() {
    // _timer!.isActive;
    _timer!.cancel();
    isTimerPaused = true;
    log('timer paused');
    update(['timer']);
  }

  void playTimer() {
    isTimerPaused = false;
    log('timer started');
    update(['timer']);
  }

  void onPressedHintButton() {
    // fillNextHint();
    if(profileController.user.availableHint>0){
      fillNextHint();
    }else{
      CustomAlert.showConfirmationDialogForWatchAd(controller: adsController);
    }
  }

  getGameDeficultiLevel() {
    switch (gameType) {
      case 'Easy':
        return GameDeficultyLevel.Easy;
      case 'Medium':
        return GameDeficultyLevel.Medium;
      case 'Hard':
        return GameDeficultyLevel.Hard;
      case 'Expert':
        return GameDeficultyLevel.Expert;

      default:
    }
  }

  void updateUserProfileForLevelPaused() {
    switch (gameType) {
      case 'Easy':
        profileController.user =
            profileController.user.copyWith(isEasyLevelPause: true);
        break;
      case 'Medium':
        profileController.user =
            profileController.user.copyWith(isMediumLevelPause: true);
        break;
      case 'Hard':
        profileController.user =
            profileController.user.copyWith(isHardLevelPause: true);
        break;
      case 'Expert':
        profileController.user =
            profileController.user.copyWith(isExpertLevelPause: true);
        break;

      default:
    }
    profileController.updateUserProfile(profileController.user);
  }

  bool isSelectedGameTypePaused() {
    switch (gameType) {
      case 'Easy':
        return profileController.user.isEasyLevelPause;
      case 'Medium':
        return profileController.user.isMediumLevelPause;
      case 'Hard':
        return profileController.user.isHardLevelPause;
      case 'Expert':
        return profileController.user.isExpertLevelPause;

      default:
        return false;
    }
  }

  void getPausedLevel() async {
    var data = await gameStateDataBase.getGameState(gameType: gameType);
    if (data == null) {
      generateSudoku();
    } else {
      puzzle = data.puzzle;
      _solution = data.solution;
      hint = data.hintList;
      remainingNumberCount = remainingNumberCount;
      time = data.time;
      // gameType=data.gameType.name;
      currentLevel = data.level;
      _startTimer(
          int.parse(time.split(':')[0]) * 60 + int.parse(time.split(':')[1]));
          update();
    }
  }
}
