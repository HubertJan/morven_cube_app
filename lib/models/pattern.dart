import 'package:flutter/material.dart';

class CubePattern {
  final List<String> patternList;
  static const possibleLetter = ["U", "D", "L", "R", "F", "B"];

  CubePattern(this.patternList);

  CubePattern.fromString(String patternString)
      : patternList = patternString.split("");

  CubePattern.copy(CubePattern old) : patternList = old.patternList.toList();

  List<String> getSide(Side side) {
    return patternList.sublist(side.index * 9, side.index * 9 + 9);
  }

  String asString() {
    String patternString = "";
    patternList.forEach((l) {
      patternString += l;
    });
    return patternString;
  }

  bool isValid() {
    var letterCounter = {};
    possibleLetter.forEach((l) {
      letterCounter[l] = 0;
    });
    bool isValid = true;
    patternList.forEach((l) {
      if (!possibleLetter.contains(l)) {
        isValid = false;
      }
      letterCounter[l] += 1;
      if (letterCounter.length > 9) {
        isValid = false;
      }
    });
    return isValid;
  }
}

enum Side {
  // DO NOT CHANGE THE ORDER OF THAT LIST
  up,
  right,
  front,
  down,
  left,
  back,
}

const sideToIndex = {
  Side.up: 0,
  Side.right: 9,
  Side.front: 18,
  Side.down: 27,
  Side.left: 36,
  Side.back: 45,
};
