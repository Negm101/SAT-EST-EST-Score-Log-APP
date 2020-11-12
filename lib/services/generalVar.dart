
import 'package:flutter/material.dart';

class MyColors extends Color {
  MyColors.primary() : super(_getColorFromHex('215A84'));

  MyColors.primaryDark() : super(_getColorFromHex('032B43'));

  MyColors.black() : super(_getColorFromHex('000000'));

  MyColors.white() : super(_getColorFromHex('FFFFFF'));

  MyColors.yellow() : super(_getColorFromHex('FFBA08'));

  MyColors.green() : super(_getColorFromHex('136F63'));

  MyColors.primaryLight() : super(_getColorFromHex('3F88C5'));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

