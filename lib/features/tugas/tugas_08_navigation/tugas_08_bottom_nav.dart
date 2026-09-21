import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';

class Tugas08BottomNavWidget extends StatefulWidget {
  const Tugas08BottomNavWidget({super.key});

  @override
  State<Tugas08BottomNavWidget> createState() => _Tugas08BottomNavWidgetState();
}

class _Tugas08BottomNavWidgetState extends State<Tugas08BottomNavWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B82F6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}

