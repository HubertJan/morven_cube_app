import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';

class Process with ChangeNotifier {
  final String url;
  Process(this.url);

  bool isRunning = false;

  Future<void> fetchAndSetData() async {
    try {
      final url = '${this.url}/runningJob';
      final response = await http.get(url);
      isRunning = response.statusCode == 200;
    } catch (e) {
      return e;
    }
  }

  Future<void> fetchUntilIsNotRunningAndSetData() async {
    try {
      while (true) {
        final url = '${this.url}/runningJob';
        final response = await http.get(url);
        if (response.statusCode == 204) {
          isRunning = false;
          return;
        }
      }
    } catch (e) {
      return e;
    }
  }
}
