import 'package:flutter/material.dart';

import '../models/pattern.dart';
import '../widgets/rubiks_side_container.dart';
import "../screens/single_pattern_side_edit_screen.dart";

class PatternEditScreen extends StatefulWidget {
  static const routeName = '/patternEditScreen';

  @override
  _PatternEditScreenState createState() => _PatternEditScreenState();
}

class _PatternEditScreenState extends State<PatternEditScreen> {
  Pattern pattern;

  Widget RubiksSideCard(Pattern pattern, Side side, String title) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        children: [
          Text(title),
          SizedBox(
            height: 5,
          ),
          RubiksSideContainer(pattern: pattern, side: side),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (pattern == null) {
      pattern = ModalRoute.of(context).settings.arguments;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Zauberwürfelmuster")),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SinglePatternSideEditScreen.routeName,
                            arguments: pattern)
                        .then((result) {
                      if (result == null) {
                        return;
                      }
                      pattern = result;
                      setState(() {});
                    });
                  },
                  child: RubiksSideCard(pattern, Side.front, "Vorderseite")),
              RubiksSideCard(pattern, Side.back, "Rückseite")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RubiksSideCard(pattern, Side.left, "Linkeseite"),
              RubiksSideCard(pattern, Side.right, "Rechteseite")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RubiksSideCard(pattern, Side.up, "Oberseite"),
              RubiksSideCard(pattern, Side.down, "Unterseite")
            ],
          ),
        ],
      ),
    );
  }
}
