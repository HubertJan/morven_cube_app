import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../provider/historyEntry.dart';
import '../models/pattern.dart';

class HistoryEntries extends ChangeNotifier {
  List<HistoryEntry> _entries = [];
  final String url;

  HistoryEntries(this.url);

  List<HistoryEntry> get entries {
    return [..._entries];
  }

  Future<void> fetchAndSetEntries() async {
    final response = await http.get('${this.url}/runthroughs');
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    List<dynamic> records = extractedData["data"];
    _entries.clear();
    records.forEach((data) {
      _entries.add(
        HistoryEntry(
          id: data["id"],
          time: data["runtime"].toInt(),
          date: data["date"],
          startPattern: CubePattern.fromString(data["startPattern"]),
          endPattern: CubePattern.fromString(data["endPattern"]),
          instructions: data["instructions"],
        ),
      );
    });
    notifyListeners();
  }
}
