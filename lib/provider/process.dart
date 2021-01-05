import 'package:http/http.dart' as http;
import 'dart:convert';

import './historyEntry.dart';

class Process {
  String getProgram() {
    return "";
  }

  String getCurrentStep() {
    return "";
  }

  Future<HistoryEntry> getResult() async {
    var isFinished = false;
    while (isFinished == false) {
      var response = await http.get("/status");
      var values = json.decode(response.body);
      if (values["status"] == "FINISHED") {
        isFinished = true;
      }
    }
  }
}
