import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';
import 'config.dart';

ThemeData themeData(ThemeData baseTheme) {
  ThemeColors.loadColors();
  return baseTheme.copyWith(
    primaryColor: ThemeColors.primaryColor,
    backgroundColor: ThemeColors.backgroundColor,
    scaffoldBackgroundColor: ThemeColors.backgroundColor,
    colorScheme: baseTheme.colorScheme.copyWith(
      secondary: ThemeColors.accentColor,
    ),
    dividerColor: Colors.transparent,
    iconTheme: baseTheme.iconTheme.copyWith(
      color: baseTheme.colorScheme.secondary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline2: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline3: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline4: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline5: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 22.sp,
      ),
      subtitle1: TextStyle(
        color: ThemeColors.textGreyColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 19.sp,
      ),
      subtitle2: TextStyle(
        color: ThemeColors.textLightColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      bodyText1: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      ),
      bodyText2: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontSize: 17.sp,
      ),
      button: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      overline: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: ThemeColors.backgroundColor,
      titleTextStyle: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: ThemeColors.black,
      ),
    ),
  );
}
