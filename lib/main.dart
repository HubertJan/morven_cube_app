import 'package:flutter/material.dart';
import 'package:morven_cube_app/provider/historyEntries.dart';
import 'package:morven_cube_app/screens/single_pattern_side_edit_screen.dart';
import 'package:provider/provider.dart';

import './screens/solve_viewer_screen.dart';
import './screens/tabs_screen.dart';
import './screens/pattern_edit_screen.dart';
import "./screens/custom_solve_screen.dart";
import './screens/result_solve_screen.dart';
import './screens/pattern_viewer_screen.dart';
import './screens/auth_screen.dart';
import './provider/status.dart';
import './provider/historyEntries.dart';
import './provider/process.dart';
import './provider/sensor.dart';
import './provider/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Status("http://10.0.2.2:9000"),
        ),
        ChangeNotifierProvider.value(
          value: Process("http://10.0.2.2:9000"),
        ),
        ChangeNotifierProvider.value(
          value: HistoryEntries("http://10.0.2.2:9000"),
        ),
        ChangeNotifierProvider.value(
          value: Sensor("http://10.0.2.2:9000"),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(0, 87, 255, 1),
            backgroundColor: Color.fromRGBO(245, 245, 245, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/",
          routes: {
            '/':
                auth.isVerified ? (ctx) => TabsScreen() : (ctx) => AuthScreen(),
            CustomSolveScreen.routeName: (ctx) => CustomSolveScreen(),
            SolveViewerScreen.routeName: (ctx) => SolveViewerScreen(),
            ResultSolveScreen.routeName: (ctx) => ResultSolveScreen(),
            PatternViewerScreen.routeName: (ctx) => PatternViewerScreen(),
            SinglePatternSideEditScreen.routeName: (ctx) =>
                SinglePatternSideEditScreen(),
            PatternEditScreen.routeName: (ctx) => PatternEditScreen(),
          },
        ),
      ),
    );
  }
}
