import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/product_catalog.dart';
import 'package:jewellery_app/views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown),
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewellery Store',
      theme: _buildTheme(Brightness.light
      ),
      //home: const ProductCatalog(),
      home: const WelcomeScreen(),
    );
  }
}
