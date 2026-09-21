import 'package:flutter/material.dart';

class LatDrawerScreen extends StatefulWidget {
  const LatDrawerScreen({super.key});

  @override
  State<LatDrawerScreen> createState() => _LatDrawerScreenState();
}

class _LatDrawerScreenState extends State<LatDrawerScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Beranda Utama', 'Tagihan & Billing', 'Pusat Laporan', 'Profil Pengguna'];
  final List<IconData> _icons = [Icons.home, Icons.receipt_long, Icons.assessment, Icons.person];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Drawer: ${_titles[_selectedIndex]}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Budi Setiawan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('budi@example.co.id'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "B",
                  style: TextStyle(fontSize: 32.0, color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Billing'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.assessment),
              title: const Text('Laporan'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_icons[_selectedIndex], size: 72, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Halaman ${_titles[_selectedIndex]}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Buka navigasi samping (Drawer) atau tekan tombol navigasi di bawah.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'Laporan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

