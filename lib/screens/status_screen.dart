import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/status.dart';

class StatusScreen extends StatelessWidget {
  static const routeName = '/statusScreen';
  Status _status = Status();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _status.fetchAndSetData(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Text(_status.status),
            );
          }
        },
      ),
    );
  }
}
