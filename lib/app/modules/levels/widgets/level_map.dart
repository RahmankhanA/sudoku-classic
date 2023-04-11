import 'package:flutter/material.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';

import 'bubble.dart';
import 'mapline_painter1.dart';
import 'mapline_painter2.dart';

const divisor = 6;

class GameLevelMap extends StatefulWidget {
  final int currentLevel;
  final String gameType;

  const GameLevelMap({
    super.key,
    required this.currentLevel,
    required this.gameType,
  });
  @override
  State<StatefulWidget> createState() => _GameLevelMapState();
}

class _GameLevelMapState extends State<GameLevelMap> {
  List<List<Widget>> paired = [];

  double stroke = 50.0;
  double spaceCurve = 130.0;
  int itemCount = 50;
  // int itemCount = 500000;

  late MapLinePainter1 mapLinePainter1;
  late MapLinePainter2 mapLinePainter2;
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();

    // levelWidgets = widget.levelWidgets;

    // levelWidgets = levelWidgets.reversed.toList();
    mapLinePainter1 =
        MapLinePainter1(LevelColor.levelMapBackgroundColor, stroke);
    mapLinePainter2 =
        MapLinePainter2(LevelColor.levelMapBackgroundColor, stroke);
    _controller = ScrollController();
    _goToCurrentLevel();
    // _controller.animateTo(78.0,
    //     duration: const Duration(seconds: 1), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    // log("length of list :${levelWidgets.length}");
    // log(Theme.of(context).focusColor.toString());
    return ListView.builder(
      controller: _controller,
      itemCount: (itemCount).ceil(),
      // itemCount: (levelWidgets.length / 2).ceil(),
      itemBuilder: (context, index) {
        index = itemCount - index;

        return SizedBox(
          // key: GlobalObjectKey(index),
          height: spaceCurve,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, spaceCurve),
                painter: index % 2 == 0 ? mapLinePainter1 : mapLinePainter2,
              ),
              Positioned(
                left: index % 2 == 0 ? 100 : null,
                right: index % 2 != 0 ? 100 : null,
                top: spaceCurve / divisor,
                bottom: spaceCurve / divisor,
                child: Center(
                  child: MyBubble(
                    radius: 50,
                    color: Colors.blue,
                    number: index * 2,
                    currentLevel: widget.currentLevel,
                    isLocked: false,
                    gameType: widget.gameType,
                  ),
                ),
              ),
              Positioned(
                left: index % 2 != 0 ? 100 : null,
                right: index % 2 == 0 ? 100 : null,
                top: spaceCurve / divisor,
                bottom: spaceCurve / divisor,
                child: Center(
                  child: MyBubble(
                    radius: 50,
                    color: Colors.blue,
                    number: index * 2 - 1,
                    currentLevel: widget.currentLevel,
                    isLocked: true,
                    gameType: widget.gameType,
                  ),
                  // child: Text("Level ${index * 2 - 1} "),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _goToCurrentLevel() async {
    await Future.delayed(const Duration(seconds: 1));

    _controller.animateTo(
        spaceCurve * (itemCount - widget.currentLevel / 2 - 3),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutQuart);
  }
}
