import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../provider/process.dart';
import '../screens/result_solve_screen.dart';

class SolveViewerScreen extends StatefulWidget {
  static const routeName = '/solveViewerScreen';

  @override
  _SolveViewerScreenState createState() => _SolveViewerScreenState();
}

class _SolveViewerScreenState extends State<SolveViewerScreen> {
  var _wasFetchedOnce = false;
  @override
  void initState() {
    super.initState();
    var _isFetched = false;
    var _isFetching = false;

    final _everySecond = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      if (_isFetching) {
        if (_isFetched) {
          _isFetched = false;
          _isFetching = false;
          if (Provider.of<Process>(context).status == "FINISHED") {
            t.cancel();
            Navigator.of(context).popAndPushNamed(ResultSolveScreen.routeName);
          } else {
            _wasFetchedOnce = true;
            setState(() {});
          }
        }
      } else {
        _isFetching = true;
        Provider.of<Process>(context).fetchAndSetData().then((_) {
          _isFetched = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var body;
    if (Provider.of<Process>(context).status == "" ||
        Provider.of<Process>(context).status == "IDLE" ||
        _wasFetchedOnce == false) {
      body = Center(child: CircularProgressIndicator());
    } else {
      final process = Provider.of<Process>(context);
      final instructionId = process.currentInstructionId + 1;
      final instructionLength = process.instructions.length;

      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$instructionId / $instructionLength'),
          LinearProgressIndicator(
            minHeight: 30,
            value: instructionId / instructionLength,
          ),
        ],
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
