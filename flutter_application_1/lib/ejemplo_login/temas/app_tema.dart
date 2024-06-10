import 'package:flutter/material.dart';

class AppTema {

  static const Color primary = Colors.pinkAccent;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.pink,
    appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 0
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom( primary: primary )
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        elevation: 5
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: primary,
          shape: const StadiumBorder(),
          elevation: 0
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle( color: primary ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide( color: primary ),
          borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),

      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide( color: primary ),
          borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),

      border: OutlineInputBorder(
          borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),
    )
  );
}