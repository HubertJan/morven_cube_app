import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/solveSetting.dart';

class Status extends ChangeNotifier {
  String url;

  Status(this.url);

  Future<String> postPattern(String newPattern, {SolveSetting setting}) async {
    try {
      String jsonData = null;
      final requestURL = '${this.url}/solveCube/$newPattern';
      if (setting != null) {
        jsonData = jsonEncode(setting);
      }
      final response = await http.post(requestURL, body: jsonData);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData["id"];
    } catch (error) {
      throw error;
    }
  }
}
