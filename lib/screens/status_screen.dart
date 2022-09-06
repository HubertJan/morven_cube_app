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
import '../screens/pattern_screens/pattern_edit_screen.dart';

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sensor",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 14),
            Container(
              child: FutureBuilder(
                future: Provider.of<Sensor>(context).fetchAndSetData(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  } else {
                    return Consumer<Sensor>(
                      builder: (ctx, sensor, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Temp1",
                                variableText: sensor.temp1,
                              ),
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Temp2",
                                variableText: sensor.temp2,
                              ),
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Temp3",
                                variableText: sensor.temp3,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Volt",
                                variableText: sensor.volt1,
                              ),
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Volt2",
                                variableText: sensor.volt2,
                              ),
                              SizedBox(height: 20),
                              VerticalVariableTile(
                                title: "Volt3",
                                variableText: sensor.volt3,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
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
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
