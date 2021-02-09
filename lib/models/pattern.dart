import 'package:flutter/material.dart';

class Pattern {
  final List<String> patternList;
  static const SIDE_POSITION_IN_PATTERN = {
    Side.front: 0,
  };

  Pattern(this.patternList);

  Pattern.fromString(String patternString)
      : patternList = patternString.split("");

  Pattern.copy(Pattern old) : patternList = old.patternList.toList();

  List<String> getSide(Side side) {
    return patternList.sublist(side.index * 9, side.index * 9 + 9);
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
