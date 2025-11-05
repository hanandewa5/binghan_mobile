import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData mainThemes = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF672D4A),
    // accentColor: Color(0xFFBEA236),
    // backgroundColor: Color(0xFFF6F6F6),
    // errorColor: Colors.red,
    fontFamily: 'Poppins-Bold',
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF672D4A),
      onPrimary: Color.fromARGB(255, 255, 255, 255),
      secondary: Color(0xFFBEA236),
      onSecondary: Color.fromARGB(255, 200, 188, 141),
      error: Colors.red,
      onError: Colors.red,
      surface: Color(0xFFF6F6F6),
      onSurface: Color.fromARGB(255, 55, 55, 55),
    ),
    scaffoldBackgroundColor: Color(0xFFF6F6F6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF672D4A),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Poppins-Bold',
        fontWeight: FontWeight.bold,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xFFBEA236), width: 2.0),
      ),
      labelColor: Color(0xFFBEA236),
      unselectedLabelColor: Colors.white,
      labelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Poppins-Bold'),
    ),
    textTheme: TextTheme(
      // headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      // title: TextStyle(fontSize: 24.0, fontFamily: 'Poppins-Bold'),
      // body1: TextStyle(fontSize: 16.0, fontFamily: 'Poppins-Bold'),
      // body2: TextStyle(fontSize: 14.0, fontFamily: 'Poppins-Bold'),
    ),
  );
}
