import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {

  ListViewScreen({Key? key}) : super(key: key);

  final List<String> kategori = [
    'Buah-buahan',
    'Sayuran',
    'Elektronik',
    'Pakaian Pria',
    'Pakaian Wanita',
    'Alat Tulis Kantor',
    'Buku & Majalah',
    'Peralatan Dapur',
    'Makanan Ringan',
    'Minuman',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendekatan 1: List')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              itemCount: kategori.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(kategori[index]),
                );
              }
            )
          ]
        ),
      ),
    );
  }
}
