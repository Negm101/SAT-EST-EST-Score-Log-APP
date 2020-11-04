import 'dart:ui';

class MyColors extends Color {
  MyColors.primary() : super(_getColorFromHex('3F88C5'));

  MyColors.primaryDark() : super(_getColorFromHex('032B43'));

  MyColors.textColor() : super(_getColorFromHex('000000'));

  MyColors.textColorDark() : super(_getColorFromHex('FFFFFF'));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
