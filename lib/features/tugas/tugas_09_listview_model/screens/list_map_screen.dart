import 'package:flutter/material.dart';

class ListMapScreen extends StatelessWidget {
  const ListMapScreen({super.key});

  static const List<Map<String, dynamic>> kategori = [
    {'nama': 'Buah-buahan', 'ikon': Icons.apple, 'color': Colors.red},
    {'nama': 'Sayuran Organik', 'ikon': Icons.eco, 'color': Colors.green},
    {'nama': 'Elektronik', 'ikon': Icons.devices, 'color': Colors.blue},
    {'nama': 'Pakaian Pria', 'ikon': Icons.checkroom, 'color': Colors.indigo},
    {'nama': 'Pakaian Wanita', 'ikon': Icons.dry_cleaning, 'color': Colors.pink},
    {'nama': 'Alat Tulis Kantor', 'ikon': Icons.edit, 'color': Colors.amber},
    {'nama': 'Buku & Majalah', 'ikon': Icons.menu_book, 'color': Colors.teal},
    {'nama': 'Peralatan Dapur', 'ikon': Icons.kitchen, 'color': Colors.brown},
    {'nama': 'Makanan Ringan', 'ikon': Icons.cookie, 'color': Colors.orange},
    {'nama': 'Minuman Segar', 'ikon': Icons.local_drink, 'color': Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendekatan 2: List<Map>'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          final item = kategori[index];
          final color = item['color'] as Color? ?? Colors.blue;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(item['ikon'] as IconData, color: color),
              ),
              title: Text(
                item['nama'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}

