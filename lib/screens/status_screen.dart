import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../provider/status.dart';

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
      body: FutureBuilder(
        future: Provider.of<Status>(context).fetchAndSetData(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            if (Provider.of<Status>(context).statusCode == "") {
              return Center(child: CircularProgressIndicator());
            }
          }
          return Center(
            child: Text(Provider.of<Status>(context).statusCode),
          );
        },
      ),
    );
  }
}
