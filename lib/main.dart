import 'package:flutter/material.dart';
import 'package:nala/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

      //theme festlegen auch wenn ich nicht ganz weis was das macht
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // App-Hintergrund
        primaryColor: Colors.deepPurple, // Hauptfarbe
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
