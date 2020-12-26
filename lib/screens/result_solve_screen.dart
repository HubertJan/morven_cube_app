import 'package:flutter/material.dart';

import '../widgets/custom_tile_list.dart';
import '../widgets//slider_list_tile.dart';

class ResultSolveScreen extends StatelessWidget {
  static const routeName = '/resultSolveScreen';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Auswertung",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomTileList(
            title: "Statistik",
            tiles: [
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: const Text("Zeit"),
                  trailing: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "10s",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: const Text("Schritte"),
                  trailing: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "14",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: const Text("Scramble"),
                  trailing: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Aus",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomTileList(title: "Muster", tiles: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Startmuster", style: TextStyle(fontSize: 16)),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.yellow,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            )
          ])
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop()),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text("Wiederholen"),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
