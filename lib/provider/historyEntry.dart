import 'package:flutter/material.dart';

import '../models/pattern.dart';

class HistoryEntry {
  final int time;
  final String date;

  final Pattern startPattern;
  final Pattern endPattern;
  final String instructions;
  final String id;

  HistoryEntry({
    @required this.id,
    @required this.time,
    @required this.date,
    @required this.startPattern,
    @required this.endPattern,
    @required this.instructions,
  });
}
