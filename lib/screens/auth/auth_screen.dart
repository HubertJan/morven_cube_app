import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verify_pattern_screen.dart';
import '../../provider/auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _controller;
  bool _validate = false;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Login", style: TextStyle(color: Colors.black)),
        ),
        body: Consumer<Auth>(
          builder: (ctx, auth, _) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Gebe die URL des Servers ein."),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: _validate ? "Kann nicht verbinden" : null,
                        hintText: 'Bitte URL eingeben'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Text("Bestätigen"),
                  onPressed: () async {
                    bool isConnected = await auth.connect(_controller.text);
                    if (isConnected) {
                      if (await auth.isVerified()) {
                        Navigator.of(context).pushReplacementNamed("/");
                      } else {
                        Navigator.of(context).pushReplacementNamed(
                            VerifyPatternScreen.routeName);
                      }
                    } else {
                      _validate = true;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
