import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';
import '../models/solveSetting.dart';

class Status extends ChangeNotifier {
  String url;

  Status(this.url);

  Future<String> postPattern(String newPattern, {SolveSetting setting}) async {
    try {
      var requestURL = "";
      if (setting != null) {
        requestURL = '${this.url}/solveCube/$newPattern';
      } else {
        requestURL = '${this.url}/solveCube/$newPattern';
      }

      final response = await http.post(requestURL);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData["id"];
    } catch (error) {
      throw error;
    }
  }
}
