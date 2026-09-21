import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  static const List<String> kategori = [
    'Buah-buahan Segar',
    'Sayuran Organik',
    'Elektronik & Gadget',
    'Pakaian Pria',
    'Pakaian Wanita',
    'Alat Tulis Kantor',
    'Buku & Majalah',
    'Peralatan Dapur',
    'Makanan Ringan & Snack',
    'Minuman Sehat & Jus',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendekatan 1: List<String>'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: kategori.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('${index + 1}'),
            ),
            title: Text(
              kategori[index],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          );
        },
      ),
    );
  }
}
