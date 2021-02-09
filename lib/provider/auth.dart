import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/pattern.dart';

class Auth extends ChangeNotifier {
  String _url;

  Future<bool> connect(String url) async {
    try {
      final response = await http.get('$url/status');
      final responseData = json.decode(response.body);
      if (responseData['status'] == null) {
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
    final response = await http.get('$_url/verified');
    final responseData = json.decode(response.body);
    return responseData["verified"];
  }

  Future<Pattern> getToBeVerifiedPattern() async {
    if (_url == null) {
      throw Exception();
    }

    final response = await http.get('$_url/toVerifyPattern');
    final responseData = json.decode(response.body);
    return Pattern.fromString(responseData["pattern"]);
  }

  Future<void> verifyPattern(String pattern) async {
    if (_url == null) {
      throw Exception();
    }

    var resp = await http.patch('$_url/toVerifyPattern/$pattern');
    final response = await http.patch('$_url/verified/true');
    if (response.statusCode == 303) {
      return;
    }
  }
}
