import 'package:flutter/material.dart';
import 'package:morven_cube_app/models/pattern.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../provider/status.dart';
import '../widgets/rubiks_side_container.dart';
import '../widgets/vertical_variable_tile.dart';

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
          return Consumer<Status>(builder: (ctx, status, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RubiksSideContainer(
                      pattern: status.pattern, side: Side.front),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Text(
                          "Idle",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prozess",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 14),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 14),
                            VerticalVariableTile(
                              title: "Instruktionen",
                              variableText: status.statusCode,
                            ),
                            SizedBox(height: 7),
                            VerticalVariableTile(
                              title: "Instruktionen",
                              variableText: status.statusCode,
                            ),
                            SizedBox(height: 7),
                            VerticalVariableTile(
                              title: "Instruktionen",
                              variableText: status.statusCode,
                            ),
                            SizedBox(height: 14),
                          ],
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      )
                    ],
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
