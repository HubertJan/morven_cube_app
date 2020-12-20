import 'package:flutter/material.dart';

import '../widgets/history_tile.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Verlauf",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.end,
          ),
        ),
      ),
      body: Padding(
        padding: new EdgeInsets.only(top: statusBarHeight),
        child: Stack(
          children: [
            Container(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HistoryTile("5s", 13, "15:45 25.09.2020"),
                  SizedBox(
                    height: 1,
                  ),
                  HistoryTile("5s", 13, "15:45 25.09.2020"),
                  SizedBox(
                    height: 1,
                  ),
                  HistoryTile("5s", 13, "15:45 25.09.2020"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
