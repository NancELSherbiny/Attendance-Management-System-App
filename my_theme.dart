import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor= Color(0xff005582);
  static Color lightBlue= Color(0xff97ebdb);

  static ThemeData lightMode = ThemeData(
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 5,
          centerTitle: true,
      ),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   selectedItemColor: blackColor,
      //   unselectedItemColor: whiteColor,
      //   showUnselectedLabels: true,
      // ),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 34),
        titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ));
}