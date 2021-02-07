import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';

class Sensor extends ChangeNotifier {
  Pattern temp1;
  String temp2;
  String url;

  Sensor(this.url);

  Future<void> fetchAndSetData() async {
    final url = '${this.url}/status';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    this.temp1 = extractedData["temp"];
    this.temp2 = extractedData["temp2"];
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
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
