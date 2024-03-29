import 'package:flutter/material.dart';
import 'package:morven_cube_app/screens/pattern_screens/single_pattern_side_edit_screen.dart';

import '../../models/pattern.dart';
import '../../widgets/rubiks_side_container.dart';

class PatternEditScreen extends StatefulWidget {
  static const routeName = '/patternEditScreen';

  @override
  _PatternEditScreenState createState() => _PatternEditScreenState();
}

class _PatternEditScreenState extends State<PatternEditScreen> {
  CubePattern pattern;

  Widget rubiksSideCard(CubePattern pattern, Side side, String title) {
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

  Widget buttonRubiksSideCard(Side side, String title) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(SinglePatternSideEditScreen.routeName,
              arguments: [pattern, side]).then((result) {
            if (result == null) {
              return;
            }
            pattern = result;
            setState(() {});
          });
        },
        child: rubiksSideCard(pattern, side, title));
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
                icon: Icon(Icons.done),
                onPressed: () {
                  if (pattern.isValid()) {
                    Navigator.of(context).pop(pattern);
                  }
                }),
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
              buttonRubiksSideCard(Side.front, "Vorderseite"),
              buttonRubiksSideCard(Side.back, "Rückseite"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonRubiksSideCard(Side.left, "Linke Seite"),
              buttonRubiksSideCard(Side.right, "Rechte Seite"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonRubiksSideCard(Side.up, "Oberseite"),
              buttonRubiksSideCard(Side.down, "Unterseite"),
            ],
          ),
        ],
      ),
    );
  }
}
