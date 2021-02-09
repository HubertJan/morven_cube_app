import 'package:flutter/material.dart';
import 'package:morven_cube_app/models/pattern.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../provider/status.dart';
import '../provider/process.dart';
import '../provider/sensor.dart';
import '../widgets/rubiks_side_container.dart';
import '../widgets/vertical_variable_tile.dart';
import '../widgets/status_tile.dart';
import '../screens/pattern_edit_screen.dart';

class StatusScreen extends StatefulWidget {
  static const routeName = '/statusScreen';

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
          future: Provider.of<Status>(context).fetchAndSetData(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              if (Provider.of<Status>(context).statusCode == "") {
                return Center(child: CircularProgressIndicator());
              }
            }
            return Consumer<Status>(
              builder: (ctx, status, processWidget) {
                return Container(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PatternEditScreen.routeName,
                                      arguments: status.pattern)
                                  .then((pattern) {
                                if (pattern != null) {
                                  status.pattern = pattern;
                                }
                              });
                            },
                            child: RubiksSideContainer(
                                pattern: status.pattern, side: Side.front),
                          ),
                          SizedBox(
                            height: 75,
                          ),
                          StatusTile(status.statusCode),
                          SizedBox(height: 30),
                          status.statusCode != "IDLE"
                              ? processWidget
                              : SizedBox(),
                          SizedBox(height: 75),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sensor",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 14),
                              Container(
                                child: FutureBuilder(
                                  future: Provider.of<Sensor>(context)
                                      .fetchAndSetData(),
                                  builder: (ctx, dataSnapshot) {
                                    if (dataSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      return Consumer<Sensor>(
                                        builder: (ctx, sensor, _) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(height: 20),
                                            VerticalVariableTile(
                                              title: "Instruktionen",
                                              variableText: sensor.temp1,
                                            ),
                                            SizedBox(height: 20),
                                            VerticalVariableTile(
                                              title: "Aktuelle Instruktion",
                                              variableText: sensor.temp2,
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prozess",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 14),
                  Container(
                    child: FutureBuilder(
                      future: Provider.of<Process>(context).fetchAndSetData(),
                      builder: (ctx, dataSnapshot) {
                        if (dataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return Consumer<Process>(
                            builder: (ctx, process, _) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 20),
                                VerticalVariableTile(
                                  title: "Instruktionen",
                                  variableText:
                                      '"${process.instructionsToString()}"',
                                ),
                                SizedBox(height: 20),
                                VerticalVariableTile(
                                  title: "Aktuelle Instruktion",
                                  variableText:
                                      process.currentInstructionId.toString(),
                                ),
                                SizedBox(height: 20),
                                VerticalVariableTile(
                                  title: "Laufzeit",
                                  variableText:
                                      '${(process.time / 1000).toString().replaceAll(".", ",")}s',
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  )
                ],
              ),
            );
          },
        ));
  }
}
