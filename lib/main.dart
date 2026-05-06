import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cab/presentation/screens/dashboard_screen.dart';
import 'package:yatri_cab/presentation/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF38B000),
        scaffoldBackgroundColor: Color(0xFF212728),
        highlightColor: Color(0xFFD5F2C8),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            wordSpacing: 4,
            color: Colors.white,
          ),
          labelSmall: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Color(0xFFD5F2C8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: GoogleFonts.poppins(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          labelStyle: TextStyle(color: Colors.grey.shade700),
          filled: true,
          fillColor: Color(0xFFD5F2C8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
