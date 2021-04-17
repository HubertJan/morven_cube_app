import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/pattern.dart';

class Process with ChangeNotifier {
  final String url;
  Process(this.url);

  List<String> instructions;
  int currentInstructionId;
  int time;
  Pattern pattern;
  Pattern endPattern;
  String status;

  void _setDataFromJSON(Map<String, dynamic> json) {
    this.instructions = json['program'].split(" ");
    this.time = json["time"];
    this.pattern = Pattern.fromString(json["startPattern"]);
    this.endPattern = Pattern.fromString(json["endPattern"]);

    this.currentInstructionId = json['currentInstructionId'] is int
        ? json['currentInstructionId']
        : int.parse(json['currentInstructionId']);
  }

  String instructionsToString() {
    String text = "";
    this.instructions.forEach((String inst) {
      text += '$inst ';
    });
    text = text.substring(0, text.length - 1);
    return text;
  }

  Future<void> fetchAndSetData() async {
    try {
      final url = '${this.url}/process';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      status = extractedData["status"];
      if (extractedData["status"] != "IDLE") {
        _setDataFromJSON(extractedData);
      }
    } catch (e) {
      return e;
    }
  }
}
