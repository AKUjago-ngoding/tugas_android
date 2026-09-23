import 'package:flutter/material.dart';

import 'screens/catatan_screens.dart';

/// Entry point modul ini dari DashboardScreen.
/// Langsung mengarah ke DaftarCatatanScreen (halaman list catatan).
class Tugas12dan13LocalStorageWidget extends StatelessWidget {
  const Tugas12dan13LocalStorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DaftarCatatanScreen();
  }
}

