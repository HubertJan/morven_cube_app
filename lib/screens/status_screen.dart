import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatusScreen extends StatelessWidget {
  static const routeName = '/statusScreen';

  @override
  Widget build(BuildContext context) {
    http.get("http://10.0.2.2:9000/status").then((response) {
      print(response.toString);
    });

    return Scaffold(
      body: Center(child: Text("Lol")),
    );
  }
}
