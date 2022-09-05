import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth.dart';
import '../../widgets/rubiks_side_container.dart';
import '../pattern_screens/pattern_edit_screen.dart';
import '../../models/pattern.dart';

class VerifyPatternScreen extends StatefulWidget {
  static const routeName = '/verifyPattern';

  @override
  _VerifyPatternScreenState createState() => _VerifyPatternScreenState();
}

class _VerifyPatternScreenState extends State<VerifyPatternScreen> {
  Pattern pattern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [],
          title: Text("Login", style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: Consumer<Auth>(
            builder: (ctx, auth, _) => Column(
              children: [
                FutureBuilder(
                  future: auth.getToBeVerifiedPattern(),
                  builder: (ctx, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (dataSnapshot.data == null) {
                      Future.microtask(() {
                        Navigator.of(context).pushReplacementNamed("/");
                      });
                      return SizedBox();
                    } else {
                      if (pattern == null) {
                        pattern = dataSnapshot.data;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PatternEditScreen.routeName,
                                      arguments: pattern)
                                  .then((p) {
                                if (p != null) {
                                  pattern = p;
                                  setState(() {});
                                }
                              });
                            },
                            child: RubiksSideContainer(
                              pattern: pattern,
                              side: Side.front,
                            ),
                          ),
                          FlatButton(
                            child: Text("Bestätigen"),
                            onPressed: () async {
                              auth.verifyPattern(pattern.asString()).then((_) =>
                                  Navigator.of(context)
                                      .pushReplacementNamed("/"));
                            },
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
