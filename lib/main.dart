import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBoz8b2UH76wcongtMorZLESl1P9NTZABg",
        appId: "1:538046415535:web:ffe3153057d01b204c0a5a",
        messagingSenderId: "538046415535",
        projectId: "rishab-jewellers",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewellery Store',
      theme: _buildTheme(Brightness.light),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}


/*
To Do:

Done:
Added sorting feature
Add option for daily gold rate, and change price after calculating formula
gold rate+making charges()+gst (3%)
0-1gm - 600 , 1-2gm - 550 , 2-4gm - 500 , 4gm and above 450 per gram

Add a dialogue box to confirm the wishlist items

Add Home text and map that functionality
Add Phone number in sign up
Change admin portal to delete items

*/
