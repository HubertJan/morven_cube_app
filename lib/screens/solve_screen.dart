import 'package:flutter/material.dart';

import './custom_solve_screen.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_slider_button.dart';

class SolveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: new EdgeInsets.only(top: statusBarHeight),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color.fromRGBO(205, 205, 205, 1),
                      Color.fromRGBO(245, 245, 245, 1)
                    ], // red to yellow
                    tileMode: TileMode.repeated),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blue,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 40),
                  RoundedSliderButton("Lösen", () {
                    print("Hdi");
                  }),
                  SizedBox(height: 20),
                  RoundedButton("Benutzerdefiniertes Lösen", () {
                    Navigator.of(context)
                        .pushNamed(CustomSolveScreen.routeName);
                  }),
                  SizedBox(height: 20),
                  RoundedButton("Zufällig verdrehen", () {
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
