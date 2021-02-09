import 'dart:io';

import "package:flutter/material.dart";

import '../widgets/rubiks_side_container.dart';
import '../models/pattern.dart';

class SinglePatternSideEditScreen extends StatefulWidget {
  static const routeName = '/singlePatternSideEditScreen';

  @override
  _SinglePatternSideEditScreenState createState() =>
      _SinglePatternSideEditScreenState();
}

class _SinglePatternSideEditScreenState
    extends State<SinglePatternSideEditScreen> {
  String _selectedColor = "";
  Pattern pattern = null;
  final squareToColor = {
    "F": Colors.green,
    "B": Colors.blue,
    "U": Colors.white,
    "R": Colors.red,
    "L": Colors.orange,
    "D": Colors.yellow,
  };
  Widget colorPanel() {
    List<Widget> rows = [];
    List<Widget> row = [];

    for (String key in squareToColor.keys) {
      int i = rows.length * 3 + row.length;
      row.add(GestureDetector(
        onTap: () => setState(
          () => _selectedColor = key,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: squareToColor[key],
            border: _selectedColor == key
                ? Border.all(width: 5, color: Colors.black)
                : Border(),
          ),
          width: 90,
          height: 90,
        ),
      ));
      if (row.length == 3) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row,
        ));
        row = [];
      }
    }
    ;
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rows,
      ),
    );
  }

  Widget cubeContainer(Pattern pattern, Side side) {
    List<Row> rows = [];

    int i = 0;
    int index = 0;
    List<Widget> rowChildren = [];
    double cubeLength = 70;
    double border = 15;

    for (String square in pattern.getSide(side)) {
      index = i + rows.length * 3;
      rowChildren.add(
          CubeSqaureContainer(this, index + sideToIndex[side], cubeLength));
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
      width: cubeLength * 3 + border * 3,
      height: cubeLength * 3 + border * 3,
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      padding: EdgeInsets.all(border),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (pattern == null) {
      pattern = Pattern.copy(ModalRoute.of(context).settings.arguments);
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cubeContainer(
            pattern,
            Side.front,
          ),
          colorPanel(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(pattern)),
            Spacer(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Zauberwürfelmuster",
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            pattern = null;
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class CubeSqaureContainer extends StatelessWidget {
  _SinglePatternSideEditScreenState parent;
  final int id;
  final double length;

  CubeSqaureContainer(this.parent, this.id, this.length);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.parent._selectedColor == "") {
          return;
        }
        this.parent.pattern.patternList[id] = this.parent._selectedColor;
        this.parent.setState(() {});
      },
      child: new Container(
        color: this.parent.squareToColor[this.parent.pattern.patternList[id]],
        width: length,
        height: length,
      ),
    );
  }
}
