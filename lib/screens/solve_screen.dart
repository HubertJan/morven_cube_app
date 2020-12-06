import 'package:flutter/material.dart';
import "../widgets/rounded-button.dart";

class SolveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body:  Padding(
      padding: new EdgeInsets.only(top: statusBarHeight),
      child:Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color.fromRGBO(196, 196, 196, 1),
                      Color.fromRGBO(245, 245, 245, 1)
                    ], // red to yellow
                    tileMode: TileMode.repeated),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blue,
                    width: 200,
                    height: 200,
                  ),
                  RoundedButton("Benutzerdefiniert Lösen", () {
                    print("Hdi");
                  }),
                  RoundedButton("Lösen", () {
                    print("Hdi");
                  }),
                  RoundedButton("Lösen", () {
                    print("Hdi");
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
