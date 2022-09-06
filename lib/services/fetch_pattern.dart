import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morven_cube_app/provider/historyEntry.dart';

import '../models/pattern.dart';

Stream<CubePattern> fetchCurrentPatternStream({String url}) async* {
  while (true) {
    final response = await http.get('http://${url}/pattern');
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      yield CubePattern.fromString(extractedData["pattern"]);
      await Future<void>.delayed(Duration(seconds: 1));
      continue;
    }
    yield null;
  }
}
