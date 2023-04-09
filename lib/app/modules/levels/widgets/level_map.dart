import 'package:flutter/material.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';

import 'mapline_painter1.dart';
import 'mapline_painter2.dart';

const divisor = 6;

class GameLevelMap extends StatefulWidget {
  List<Widget> levelWidgets;
  GameLevelMap({required this.levelWidgets, super.key});
  @override
  State<StatefulWidget> createState() => _GameLevelMapState();
}

class _GameLevelMapState extends State<GameLevelMap> {
  List<List<Widget>> paired = [];

  double stroke = 80.0;
  double spaceCurve = 100.0;
  int itemCount = 50;

  late MapLinePainter1 mapLinePainter1;
  late MapLinePainter2 mapLinePainter2;
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();

    // levelWidgets = widget.levelWidgets;

    // levelWidgets = levelWidgets.reversed.toList();
    mapLinePainter1 = MapLinePainter1(LevelColor.backgroundColor, stroke);
    mapLinePainter2 = MapLinePainter2(LevelColor.backgroundColor, stroke);
    _controller = ScrollController();
    _goToCurrentLevel();
    // _controller.animateTo(78.0,
    //     duration: const Duration(seconds: 1), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    // log("length of list :${levelWidgets.length}");
    return ListView.builder(
      controller: _controller,
      itemCount: (itemCount).ceil(),
      // itemCount: (levelWidgets.length / 2).ceil(),
      itemBuilder: (context, index) {
        index = itemCount - index;

        return SizedBox(
          key: GlobalObjectKey(index),
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
                  // child: (index * 2 + 1) < itemCount
                  //     ? Text("Level ${itemCount - index * 2 + 1}")
                  //     : Container(),

                  // child: levelWidgets[index * 2],
                  child: Text("Level ${index * 2}"),
                ),
              ),
              Positioned(
                left: index % 2 != 0 ? 100 : null,
                right: index % 2 == 0 ? 100 : null,
                top: spaceCurve / divisor,
                bottom: spaceCurve / divisor,
                child: Center(
                  // child: (index * 2 + 1) < levelWidgets.length
                  // ? levelWidgets[index * 2 + 1]
                  // : Container(),

                  child: Text("Level ${index * 2 - 1} "),
                  // paired[index].length > 1 ? paired[index][1] : Container(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _goToCurrentLevel() async {
    await Future.delayed(const Duration(seconds: 4));
    Scrollable.ensureVisible(const GlobalObjectKey(34).currentContext!,
        duration: const Duration(seconds: 3), // duration for scrolling time
        alignment: .5, // 0 mean, scroll to the top, 0.5 mean, half
        curve: Curves.easeInOutQuart);
    // _controller.jumpTo(32.0);
    // _controller.animateTo(0,
    //     duration: const Duration(seconds: 1), curve: Curves.easeInOutQuart);
  }
}
