import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class PatternRequest {
  final String startPattern;
  final String endPattern;
  PatternRequest({
    this.startPattern,
    @required this.endPattern,
  });

  Future<String> post() async {
    final response = await http.post('/pattern/${this.endPattern}');
    if (response.statusCode == 202) {}
  }
}
