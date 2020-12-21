import 'package:flutter/material.dart';

import 'package:morven_cube_app/screens/tabs_screen.dart';
import "package:morven_cube_app/screens/custom_solve_screen.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 87, 255, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsScreen(),
      routes: {CustomSolveScreen.routeName: (ctx) => CustomSolveScreen()},
    );
  }
}
