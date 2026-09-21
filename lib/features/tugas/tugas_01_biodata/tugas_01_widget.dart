import 'package:flutter/material.dart';

class Tugas01Widget extends StatelessWidget {
  const Tugas01Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 1: Profil & Biodata'),
        backgroundColor: const Color.fromARGB(255, 116, 146, 59),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris 1: Nama lengkap
            Text(
              'Nama : Rinaldi Mulyatama',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Baris 2: Icon lokasi dan nama kota
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Baris 3: Deskripsi singkat
            Text(
              'Seseorang yang sedang belajar pemrograman berbasiskan device dengan menggunakan Flutter.',
              style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
