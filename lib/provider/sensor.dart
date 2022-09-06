import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';

class Sensor extends ChangeNotifier {
  String temp1;
  String temp2;
  String temp3;
  String volt1;
  String volt2;
  String volt3;
  String url;

  Sensor(this.url);

  Future<void> fetchAndSetData() async {
    final url = '${this.url}/sensor';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    this.temp1 = extractedData["temp"].toString();
    this.temp2 = extractedData["temp2"].toString();
    this.temp3 = extractedData["temp2"].toString();
    this.volt1 = extractedData["volt1"].toString();
    this.volt2 = extractedData["volt2"].toString();
    this.volt3 = extractedData["volt3"].toString();
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
