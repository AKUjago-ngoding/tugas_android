import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 80, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'Aplikasi Flutter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Aplikasi demo yang dibuat dengan Flutter untuk '
                'implementasi navigasi BottomNavigationBar, Drawer, '
                'dan form input.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text('Pembuat: Nama Anda'),
              Text('Versi: 1.0.0'),
            ],
          ),
        ),
      ),
    );
  }
}
