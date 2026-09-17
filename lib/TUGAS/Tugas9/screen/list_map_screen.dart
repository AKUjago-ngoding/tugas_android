import 'package:flutter/material.dart';

class ListMapScreen extends StatelessWidget {
  ListMapScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> kategori = [
    {'nama': 'Buah-buahan', 'ikon': Icons.apple},
    {'nama': 'Sayuran', 'ikon': Icons.grass},
    {'nama': 'Elektronik', 'ikon': Icons.devices},
    {'nama': 'Pakaian Pria', 'ikon': Icons.checkroom},
    {'nama': 'Pakaian Wanita', 'ikon': Icons.dry_cleaning},
    {'nama': 'Alat Tulis Kantor', 'ikon': Icons.edit},
    {'nama': 'Buku & Majalah', 'ikon': Icons.menu_book},
    {'nama': 'Peralatan Dapur', 'ikon': Icons.kitchen},
    {'nama': 'Makanan Ringan', 'ikon': Icons.cookie},
    {'nama': 'Minuman', 'ikon': Icons.local_drink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FUCKING HELL YOU')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              itemCount: kategori.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(kategori[index]['ikon']),
                  title: Text(kategori[index]['nama']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
