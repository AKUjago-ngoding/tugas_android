import 'package:flutter/material.dart';
import 'screens/tugas_splash_screen.dart';

class Tugas11AuthHubWidget extends StatelessWidget {
  const Tugas11AuthHubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Memulai alur dari Splash Screen untuk memeriksa status Token & SharedPreferences
    return const TugasSplashScreen();
  }
}

