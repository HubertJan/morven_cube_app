import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pattern.dart';

class Process {
  List<String> instructions;
  int currentInstructionId;
  int time;
  Pattern pattern;
  Process({this.instructions, this.currentInstructionId});

  Process.fromJson(Map<String, dynamic> json) {
    this.instructions = json['program'].split(" ");
    this.time = json["time"];
    this.pattern = Pattern.fromString(json["currentPattern"]);

    this.currentInstructionId = json['currentInstructionId'] is int
        ? json['currentInstructionId']
        : int.parse(json['currentInstructionId']);
  }
}
