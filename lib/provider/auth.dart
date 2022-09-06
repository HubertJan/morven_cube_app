import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/pattern.dart';

class Auth extends ChangeNotifier {
  String _url;

  String get url {
    return _url;
  }

  Future<bool> connect(String url) async {
    try {
      final response = await http.get('http://$url/server');
      bool wasSucessfull = response.statusCode == 200;
      if (wasSucessfull) {
        _url = url;
      }
      notifyListeners();
      return wasSucessfull;
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
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<CubePattern> getToBeVerifiedPattern() async {
    if (_url == null) {
      throw Exception();
    }

    final response = await http.get('http://$_url/scanPattern');
    final responseData = json.decode(response.body);
    return CubePattern.fromString(responseData["pattern"]);
  }

  Future<void> verifyPattern(String pattern) async {
    if (_url == null) {
      throw Exception();
    }

    try {
      final resp = await http.put('http://$_url/pattern/$pattern');
      if (resp.statusCode == 200) {
        return;
      }
      throw Exception("Unsucessfull request.");
    } catch (e) {
      print(e);
    }
  }
}
