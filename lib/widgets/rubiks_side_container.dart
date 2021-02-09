import 'package:flutter/foundation.dart';
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

  RubiksSideContainer({
    @required this.pattern,
    @required this.side,
  });

  @override
  Widget build(BuildContext context) {
    List<Row> rows = [];

    int i = 0;
    List<Widget> rowChildren = [];
    double cubeLength = 30;
    double border = 7;

    for (String square in pattern.getSide(side)) {
      rowChildren.add(new Container(
        color: squareToColor[square],
        width: cubeLength,
        height: cubeLength,
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
      width: cubeLength * 3 + border * 3,
      height: cubeLength * 3 + border * 3,
      padding: EdgeInsets.all(border),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rows,
      ),
    );
  }
}
