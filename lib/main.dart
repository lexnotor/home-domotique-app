import 'package:flutter/material.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/screens/home/home.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Domotique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ).copyWith(
          background: backgroundColor,
          onBackground: primaryTextColor,
          primary: primaryColor,
          onPrimary: secondaryTextColor,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
