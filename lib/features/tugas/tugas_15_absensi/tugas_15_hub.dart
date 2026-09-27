import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/splash_screen.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/login_screen.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/register_screen.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/dashboard_screen.dart';

class Tugas15Hub extends StatefulWidget {
  const Tugas15Hub({super.key});

  /// Updates the theme mode globally.
  static void updateTheme(bool isDark) {
    _themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static final ValueNotifier<ThemeMode> _themeModeNotifier = 
      ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  State<Tugas15Hub> createState() => _Tugas15HubState();
}

class _Tugas15HubState extends State<Tugas15Hub> {
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('dark_mode') ?? false;
    Tugas15Hub.updateTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Tugas15Hub._themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Absensi PPKD',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          initialRoute: '/tugas15/splash',
          routes: {
            '/tugas15/splash': (context) => const SplashScreen(),
            '/tugas15/login': (context) => const LoginScreen(),
            '/tugas15/register': (context) => const RegisterScreen(),
            '/tugas15/dashboard': (context) => const DashboardScreen(),
          },
        );
      },
    );
  }
}
