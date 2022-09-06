import 'package:flutter/material.dart';
import 'package:morven_cube_app/screens/solve/result_solve_screen.dart';
import 'package:morven_cube_app/widgets/rubiks_side_container.dart';
import 'package:provider/provider.dart';

import '../../models/pattern.dart';

import '../../provider/auth.dart';
import '../../services/fetch_pattern.dart';
import '../pattern_screens/pattern_viewer_screen.dart';
import 'custom_solve_screen.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_slider_button.dart';
import '../../provider/status.dart';

class SolveSetupScreen extends StatelessWidget {
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
            Consumer<Auth>(builder: (ctx, auth, _) {
              return StreamBuilder<CubePattern>(
                  stream: fetchCurrentPatternStream(url: auth.url),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    final data = snapshot.data;
                    return Consumer<Status>(
                      builder: (ctx, status, _) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                  PatternViewerScreen.routeName,
                                  arguments: data,
                                ),
                                child: RubiksSideContainer(
                                    pattern: data, side: Side.front),
                              ),
                              SizedBox(height: 40),
                              RoundedSliderButton("Lösen", () {
                                status.postPattern("solve").then((id) {
                                  Navigator.of(context).pushNamed(
                                      ResultSolveScreen.routeName,
                                      arguments: id);
                                });
                              }),
                              SizedBox(height: 20),
                              RoundedButton("Benutzerdefiniertes Lösen", () {
                                Navigator.of(context)
                                    .pushNamed(CustomSolveScreen.routeName);
                              }),
                              SizedBox(height: 20),
                              RoundedButton("Zufällig verdrehen", () {
                                status.postPattern("scramble").then((id) {
                                  Navigator.of(context).pushNamed(
                                      ResultSolveScreen.routeName,
                                      arguments: id);
                                });
                              })
                            ],
                          ),
                        );
                      },
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
