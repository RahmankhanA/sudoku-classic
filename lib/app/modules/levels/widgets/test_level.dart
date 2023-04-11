import 'package:flutter/material.dart';

class LevelMap2 extends StatelessWidget {
  final int numRows;
  final int numCols;

  const LevelMap2({super.key, required this.numRows, required this.numCols});

  Widget getTileWidget(int row, int col) {
    // Determine the tile type based on the row and column indices
    // You can use your own logic to determine the tile types and their corresponding colors and icons
    Color tileColor = Colors.white;
    IconData tileIcon = Icons.star_border;
    if ((row + col) % 2 == 0) {
      tileColor = Colors.grey.shade200;
    } else if (row % 3 == 0 && col % 2 == 1) {
      tileColor = Colors.blue.shade100;
    } else if (row % 2 == 1 && col % 4 == 1) {
      tileColor = Colors.pink.shade100;
      tileIcon = Icons.lock;
    } else if (row % 2 == 1 && col % 4 == 3) {
      tileColor = Colors.amber.shade100;
      tileIcon = Icons.lock;
    }

    // Create the tile widget
    return Container(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          tileIcon,
          size: 32.0,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: numRows * numCols,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numCols,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          int row = (index / numCols).floor();
          int col = index % numCols;

          Widget tile = getTileWidget(row, col);

          return GestureDetector(
            onTap: () => print("Tile $row-$col tapped!"),
            child: tile,
          );
        },
      ),
    );
  }
}

class GameLevelMap2 extends StatelessWidget {
  final int numRows;
  final int numCols;

  const GameLevelMap2(
      {super.key, required this.numRows, required this.numCols});

  Widget getTileWidget(int row, int col) {
    // Determine the tile type based on the row and column indices
    // and return a corresponding widget
    // For example:
    if (row % 2 == 0 && col % 2 == 0) {
      return Container(
        color: Colors.green,
        child: Center(
          child: Text(
            "Tile $row-$col",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Tile $row-$col",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: numRows * numCols,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numCols,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = (index / numCols).floor();
        int col = index % numCols;

        Widget tile = getTileWidget(row, col);

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => LevelScreen(level: index + 1)),
          ),
          child: tile,
        );
      },
    );
  }
}

class LevelScreen extends StatelessWidget {
  final int level;

  const LevelScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $level'),
      ),
      body: Center(
        child: Text('This is level $level'),
      ),
    );
  }
}
