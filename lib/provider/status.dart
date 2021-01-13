import 'dart:convert';

import 'package:http/http.dart' as http;

class Status {
  String status = "";

  Future<void> fetchAndSetData() async {
    final url = "http://10.0.2.2:9000/status";
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    this.status = extractedData["status"];
  }
}
