import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(), // aplica a toda la app
        useMaterial3: true,),
      home: LoginScreen(
      ),
    );
  }
}


