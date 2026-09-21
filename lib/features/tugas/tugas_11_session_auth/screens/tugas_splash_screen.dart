import 'package:flutter/material.dart';
import '../../../../core/services/preference_handler.dart';
import 'tugas_session_login_screen.dart';
import 'tugas_session_profile_screen.dart';

class TugasSplashScreen extends StatefulWidget {
  const TugasSplashScreen({super.key});

  @override
  State<TugasSplashScreen> createState() => _TugasSplashScreenState();
}

class _TugasSplashScreenState extends State<TugasSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Delay simulasi splash screen 1.5 detik
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final isLogin = PreferenceHandler.isLogin;
    final token = PreferenceHandler.authToken;

    if (isLogin && token.isNotEmpty) {
      // Jika token aktif & status login true, langsung ke Profile / Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const TugasSessionProfileScreen(),
        ),
      );
    } else {
      // Jika belum login atau token kosong, buka Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const TugasSessionLoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3), width: 2),
                ),
                child: const Icon(
                  Icons.vpn_key_rounded,
                  size: 64,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tugas Day 15: Token & Session Auth',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Memeriksa status token sesi di SharedPreferences...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 28),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

