import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/pattern.dart';

class Auth extends ChangeNotifier {
  String _url;

  Future<bool> connect(String url) async {
    try {
      final response = await http.get('http://$url/sensor');
      final responseData = json.decode(response.body);
      if (responseData['temp'] == null) {
        throw Exception();
      }
      _url = url;
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> isVerified() async {
    if (_url == null) {
      return false;
    }
    try {
      final response = await http.get('http://$_url/pattern');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Pattern> getToBeVerifiedPattern() async {
    if (_url == null) {
      throw Exception();
    }

    final response = await http.get('http://$_url/possiblePattern');
    final responseData = json.decode(response.body);
    return Pattern.fromString(responseData["pattern"]);
  }

  Future<void> verifyPattern(String pattern) async {
    if (_url == null) {
      throw Exception();
    }

    final resp = await http.patch('$_url/verifiedPattern/$pattern');
  }
}
