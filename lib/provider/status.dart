import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/process.dart';

class Status extends ChangeNotifier {
  String statusCode = "";
  Process runningProcess;
  String pattern;
  String url;

  Status(this.url);

  Future<void> fetchAndSetData() async {
    final url = '${this.url}/status';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    if (extractedData["status"] != "IDLE") {
      this.runningProcess = Process.fromJson(extractedData);
    }

    this.statusCode = extractedData["status"];
  }

  Future<void> postPattern(String newPattern) async {
    try {
      final url = '${this.url}/pattern/$newPattern';
      final response = await http.post(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      await this.fetchAndSetData();
    } catch (error) {
      throw error;
    }
  }
}
