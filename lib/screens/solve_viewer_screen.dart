import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../provider/status.dart';

class SolveViewerScreen extends StatefulWidget {
  static const routeName = '/solveViewerScreen';

  @override
  _SolveViewerScreenState createState() => _SolveViewerScreenState();
}

class _SolveViewerScreenState extends State<SolveViewerScreen> {
  Timer _everySecond;

  @override
  void initState() {
    super.initState();
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            color: Colors.white,
            height: double.infinity,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Der Würfel wird gelöst",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: LinearProgressIndicator(
                    minHeight: 30,
                    value: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Status>(context).fetchAndSetData(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            if (Provider.of<Status>(context).statusCode == "" &&
                Provider.of<Status>(context).statusCode == "IDLE") {
              return Center(child: CircularProgressIndicator());
            }
          }
          return ScrollablePositionedList.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  Provider.of<Status>(ctx).runningProcess.instructions.length,
              itemBuilder: (ctx, i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      color: Provider.of<Status>(ctx)
                                  .runningProcess
                                  .currentInstructionId ==
                              i
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: Text(
                            Provider.of<Status>(ctx)
                                .runningProcess
                                .instructions[i],
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                );
              });
        },
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
    );
  }
}
