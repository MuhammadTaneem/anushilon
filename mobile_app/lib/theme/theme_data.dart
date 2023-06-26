import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorPrimary = Colors.deepPurple ;
// const colorPrimary = Colors.orange;


const colorSecondary = Colors.teal;
const colorTextLight = Colors.white;
const colorTextDark = Colors.black87;



ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary, secondary: colorSecondary),
    useMaterial3: true,
    // textTheme: GoogleFonts.notoSerifBengaliTextTheme() ,
    textTheme: GoogleFonts.notoSansBengaliTextTheme() ,


  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: colorPrimary,
      foregroundColor: colorTextLight
      // backgroundColor: colorSecondary
    ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    filled: true,
    suffixIconColor: colorPrimary,
    fillColor: Colors.white,
    labelStyle: const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.normal,
    ),
    hintStyle: const TextStyle(
      color: Colors.black38,
    ),
    // enabledBorder: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white70,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        15
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:  BorderSide(
        color: colorPrimary,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
      gapPadding: 16,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (states) => const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(colorPrimary),
      )),
  elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (states) => const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(colorPrimary))),
  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: Colors.black12,
    collapsedBackgroundColor: Colors.white,


  )

);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary, secondary: colorSecondary),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
);
