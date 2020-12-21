import "package:flutter/material.dart";

class CustomTileList extends StatelessWidget {
  List<Widget> tiles;
  String title;

  CustomTileList({this.title, this.tiles});

  @override
  Widget build(BuildContext context) {
    List<Widget> _tiles = <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                this.title,
                style: TextStyle(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.left,
              )),
        ] +
        this.tiles;

    return Column(
      children: [
        Column(
          children: _tiles,
        )
      ],
    );
  }
}
