import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static late Color primaryColor;
  static late Color accentColor;
  static late Color darkColor;

  static late Color textPrimaryColor;
  static late Color textLightColor;
  static late Color textDarkColor;
  static late Color textGreyColor;
  static late Color textModerateColor;
  static late Color buttonDarkColor;

  static late Color shadowColor;
  static late Color shadowColorBluish;
  static late Color shadowColorFadedBluish;

  static late Color backgroundColor;

  static late Color white;
  static late Color milkyWhite;
  static late Color black;
  static late Color grey;
  static late Color blue;
  static late Color fadedBlue;
  static late Color transparent;
  static late Color brightGold;
  static late Color lightPink;
  static late Color greenishBlue;
  static late Color lightPurple;
  static late Color brightGreen;

  static late List<Color> linearGradientColors;
  static late List<Color> multiProgressBarColors;

  static void loadColors() {
    primaryColor = const Color(0xFF5142ab);
    accentColor = const Color(0xFF00BBDE);
    darkColor = const Color(0xff4D4D4D);

    textPrimaryColor = const Color(0xFF353535);
    textLightColor = const Color(0xff7D7D7D);
    textDarkColor = const Color(0xff000000);
    textGreyColor = const Color(0xff979797);
    textModerateColor = const Color(0xff5D5D5D);
    buttonDarkColor = const Color(0xff003044);

    shadowColor = const Color(0xff707070);
    shadowColorBluish = const Color(0x365b4dbc);
    shadowColorFadedBluish = const Color(0x175b4dbc);

    backgroundColor = const Color(0xFFffffff);

    white = Colors.white;
    black = Colors.black;
    grey = Colors.grey;
    blue = const Color(0xffCBECFF);
    transparent = Colors.transparent;
    milkyWhite = const Color(0xfff8f7fe);
    fadedBlue = const Color(0xffDFDBFC);
    brightGold = const Color(0xffFFDB51);
    lightPink = const Color(0xffffe9fe);
    greenishBlue = const Color(0xffe4f5fc);
    lightPurple = const Color(0xffdde0ff);
    brightGreen = const Color(0xffe3fcf8);

    linearGradientColors = const [
      Color(0xffff69c6),
      Color(0xff55cfff),
    ];

    multiProgressBarColors = const [
      Color(0xff003044),
      Color(0xff007eb1),
      Color(0xff00acef),
      Color(0xff51cfff),
    ];
  }
}
