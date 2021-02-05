import 'package:flutter/material.dart';

import '../models/pattern.dart';
import '../widgets/rubiks_side_container.dart';

class PatternViewerScreen extends StatelessWidget {
  static const routeName = '/patternViewerScreen';

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
    final Pattern pattern = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Zauberwürfelmuster")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RubiksSideCard(pattern, Side.front, "Vorderseite"),
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
