import 'package:http/http.dart' as http;
import 'dart:convert';

class Process {
  List<String> instructions;
  int currentInstructionId;

  Process({this.instructions, this.currentInstructionId});

  Process.fromJson(Map<String, dynamic> json) {
    this.instructions = json['program'].split(" ");
    this.currentInstructionId = json['currentInstructionId'] is int
        ? json['currentInstructionId']
        : int.parse(json['currentInstructionId']);
  }
}
