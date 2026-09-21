import 'package:flutter/material.dart';

class LatBottomNavScreen extends StatefulWidget {
  const LatBottomNavScreen({super.key});

  @override
  State<LatBottomNavScreen> createState() => _LatBottomNavScreenState();
}

class _LatBottomNavScreenState extends State<LatBottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(
      child: Text('Halaman 1: Beranda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('Halaman 2: Tagihan (Billing)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('Halaman 3: Laporan Statistik', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('Halaman 4: Profil Saya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Bottom Navigation Bar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

