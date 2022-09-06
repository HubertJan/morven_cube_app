import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morven_cube_app/provider/historyEntry.dart';

import '../models/pattern.dart';

Future<HistoryEntry> fetchRunthroughById({String url, String id}) async {
  final response = await http.get('http://${url}/runthroughs/${id}');
  if (response.statusCode == 200) {
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    return HistoryEntry(
      id: id,
      time: extractedData["runtime"],
      date: extractedData["date"],
      startPattern: CubePattern.fromString(extractedData["startPattern"]),
      endPattern: CubePattern.fromString(extractedData["endPattern"]),
      instructions: extractedData["instructions"],
    );
  }
  throw Exception();
}
