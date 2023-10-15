import 'package:flutter/material.dart';

const bottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
    topLeft: Radius.circular(30),
  ),
);

const requestResourceTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
);
const requestHistoryTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
);
const exploreCourseTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w300,
);
videoCourseNameTextStyle(color) => TextStyle(
      fontSize: 18,
      overflow: TextOverflow.ellipsis,
      color: color,
      fontWeight: FontWeight.w500,
    );

const Color docColor = Color(0XFF0F4FFD);
const Color pdfColor = Color(0XFFED2B2A);
const Color pptColor = Color(0XFFFD6520);
const Color videoIconColor = Color(0XFF454545);
// const Color videoIconColor = Color(0XFFDBDBDB);
const Color dateTimeColor = Color(0XFF606470);
const Color greyColor = Color(0XFF454545);
const Color orangeColor = Color(0XFFFF971D);

const ListTileThemeData listTileThemeData = ListTileThemeData(
  iconColor: orangeColor,
);

const TabBarTheme tabBarTheme = TabBarTheme(
  indicatorColor: orangeColor,
  labelColor: orangeColor,
  unselectedLabelColor: Colors.grey,
  labelStyle: TextStyle(fontSize: 16),
  indicatorSize: TabBarIndicatorSize.label,
  labelPadding: EdgeInsets.zero,
);

const FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(backgroundColor: orangeColor);

const TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
  cursorColor: orangeColor,
);

const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    focusColor: orangeColor,
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: orangeColor)));

TextButtonThemeData textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
      overlayColor: MaterialStateProperty.all(orangeColor),
      textStyle: const MaterialStatePropertyAll(TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
      ))),
);

const ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        backgroundColor: MaterialStatePropertyAll(orangeColor),
        fixedSize: MaterialStatePropertyAll(Size.fromWidth(140)),
        shape: MaterialStatePropertyAll(StadiumBorder()),
        textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white))));

const ProgressIndicatorThemeData progressIndicatorThemeData =
    ProgressIndicatorThemeData(color: orangeColor);
