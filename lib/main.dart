import 'package:flutter/material.dart';
import 'screens/music_comparison_screen.dart';

void main() {
  runApp(MusicComparisonApp());
}

class MusicComparisonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparaison Musicale',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal, // Couleur principale
        scaffoldBackgroundColor: Colors.black, // Couleur de fond
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white), // Remplace headline6 par displayLarge
          bodyLarge: TextStyle(color: Colors.white), // Remplace bodyText1 par bodyLarge
          bodyMedium: TextStyle(color: Colors.grey[400]), // Remplace bodyText2 par bodyMedium
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey[500]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Couleur de fond du bouton
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: MusicComparisonScreen(),
    );
  }
}
