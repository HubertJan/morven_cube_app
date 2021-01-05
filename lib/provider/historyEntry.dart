import 'package:flutter/material.dart';

import '../models/program.dart';

class HistoryEntry {
  final int time;
  final int date;
  final String startPattern;
  final String endPattern;
  final Program program;

  HistoryEntry({
    @required this.time,
    @required this.date,
    @required this.startPattern,
    @required this.endPattern,
    @required this.program,
  });
}
