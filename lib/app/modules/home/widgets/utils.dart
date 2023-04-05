import 'package:flutter/cupertino.dart';

List<List<Widget>> pairLevel(List<Widget> levelWidgets) {
  List<List<Widget>> paired = [];
  for (int i = 0; i < levelWidgets.length; i += 2) {
    List<Widget> pair = [];
    var widget1 = levelWidgets[i];
    pair.add(widget1);
    if (i < levelWidgets.length - 1) {
      var widget2 = levelWidgets[i + 1];
      pair.add(widget2);
    }
    paired.add(pair);
  }
  return paired;
}
