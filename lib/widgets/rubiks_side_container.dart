import "package:flutter/material.dart";

import '../models/pattern.dart';

class RubiksSideContainer extends StatelessWidget {
  final Pattern pattern;
  final Side side;
  final squareToColor = {
    "F": Colors.green,
    "B": Colors.blue,
    "U": Colors.white,
    "R": Colors.red,
    "L": Colors.orange,
    "D": Colors.yellow,
  };

  RubiksSideContainer(this.pattern, this.side);

  @override
  Widget build(BuildContext context) {
    List<Row> rows = [];

    int i = 0;
    List<Widget> rowChildren = [];

    for (String square in pattern.getSide(side)) {
      rowChildren.add(new Container(
        color: squareToColor[square],
        width: 30,
        height: 30,
      ));
      i += 1;
      if (i == 3) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ));
        i = 0;
        rowChildren = [];
      }
    }

    return Container(
      color: Colors.black87,
      width: 110,
      height: 110,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rows,
      ),
    );
  }
}
