import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/pattern.dart';

class Auth extends ChangeNotifier {
  String _url;
  bool isVerified = false;

  Future<bool> connect(String url) async {
    try {
      final response = await http.get('$url/status');
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw Exception();
      }
      _url = url;
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Pattern> getToBeVerifiedPattern() async {
    if (_url == null) {
      throw Exception();
    }

    final response = await http.get('$_url/pattern');
    final responseData = json.decode(response.body);
    return Pattern.fromString(responseData["currentPattern"]);
  }

  Future<void> verifyPattern() async {
    if (_url == null) {
      throw Exception();
    }

    final response = await http.post('$_url/pattern/verify');
    final responseData = json.decode(response.body);
    isVerified = responseData["verified"] == "true" ? true : false;
  }
}
