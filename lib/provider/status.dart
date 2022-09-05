import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';
import '../models/solveSetting.dart';

class Status extends ChangeNotifier {
  String statusCode = "";
  Pattern pattern;
  String programId;
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
      this.programId = extractedData["programId"];
    }

    this.statusCode = extractedData["status"];
    this.pattern = Pattern.fromString(extractedData["currentPattern"]);
  }

  Future<void> postPattern(String newPattern, {SolveSetting setting}) async {
    try {
      var requestURL = "";
      if (setting != null) {
        requestURL = '${this.url}/pattern/$newPattern';
      } else {
        requestURL = '${this.url}/pattern/$newPattern';
      }

      final response = await http.patch(requestURL);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      await this.fetchAndSetData();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
