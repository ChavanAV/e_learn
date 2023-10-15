import 'package:e_learn/resources/user_provider.dart';
import 'package:e_learn/utils/decoration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow only portrait orientation
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModel(),
        ),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color primaryColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    Map<int, Color> swatch = {
      50: primaryColor.withOpacity(0.1),
      100: primaryColor.withOpacity(0.2),
      200: primaryColor.withOpacity(0.3),
      300: primaryColor.withOpacity(0.4),
      400: primaryColor.withOpacity(0.5),
      500: primaryColor.withOpacity(0.6),
      600: primaryColor.withOpacity(0.7),
      700: primaryColor.withOpacity(0.8),
      800: primaryColor.withOpacity(0.9),
      900: primaryColor.withOpacity(1.0),
    };
    MaterialColor primarySwatch = MaterialColor(primaryColor.value, swatch);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepOrange,
        indicatorColor: orangeColor,
        primarySwatch: primarySwatch,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        listTileTheme: listTileThemeData,
        tabBarTheme: tabBarTheme,
        textSelectionTheme: textSelectionThemeData,
        inputDecorationTheme: inputDecorationTheme,
        textButtonTheme: textButtonThemeData,
        elevatedButtonTheme: elevatedButtonThemeData,
        progressIndicatorTheme: progressIndicatorThemeData,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0XFFDFDFDE)),
        appBarTheme: const AppBarTheme(
            surfaceTintColor: Color(0XFFE3E3E3),
            backgroundColor: Colors.white38),
      ),
      //Start Dark Theme From Here:-
      //============================//
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        listTileTheme: listTileThemeData,
        tabBarTheme: tabBarTheme,
        indicatorColor: orangeColor,
        textSelectionTheme: textSelectionThemeData,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        inputDecorationTheme: inputDecorationTheme,
        textButtonTheme: textButtonThemeData,
        elevatedButtonTheme: elevatedButtonThemeData,
        progressIndicatorTheme: progressIndicatorThemeData,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: greyColor, selectedItemColor: Colors.white),
        appBarTheme: const AppBarTheme(
            surfaceTintColor: Color(0XFF383838), backgroundColor: greyColor),
      ),
      themeMode: Provider.of<ThemeModel>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
