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
  CubePattern pattern;
  bool _isInvalid = false;

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
                                  _isInvalid = false;
                                  setState(() {});
                                }
                              });
                            },
                            child: RubiksSideContainer(
                              pattern: pattern,
                              side: Side.front,
                            ),
                          ),
                          if (_isInvalid)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Muster ist ungültig.",
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            child: Text("Bestätigen"),
                            onPressed: () async {
                              try {
                                await auth.verifyPattern(pattern.asString());
                                Navigator.of(context).pushReplacementNamed("/");
                              } catch (_) {
                                _isInvalid = true;
                                setState(() {});
                              }
                            },
                          ),
                          TextButton(
                              onPressed: () async {
                                try {
                                  pattern = await auth.getToBeVerifiedPattern();
                                  setState(() {});
                                  _isInvalid = false;
                                } catch (_) {}
                              },
                              child: Text("Nochmal scannen"))
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
