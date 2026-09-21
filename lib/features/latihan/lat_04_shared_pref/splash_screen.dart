import 'package:flutter/material.dart';
import '../../../core/services/preference_handler.dart';
import 'session_login_screen.dart';

class LatSplashScreen extends StatefulWidget {
  const LatSplashScreen({super.key});

  @override
  State<LatSplashScreen> createState() => _LatSplashScreenState();
}

class _LatSplashScreenState extends State<LatSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final isLogin = PreferenceHandler.isLogin;
    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HalamanTerimaKasih(
            email: PreferenceHandler.userEmail.isEmpty
                ? 'User Terdaftar'
                : PreferenceHandler.userEmail,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LatSessionLoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/G.jpg",
                width: 140,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.flutter_dash,
                  size: 100,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Aplikasi Latihan Shared Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
