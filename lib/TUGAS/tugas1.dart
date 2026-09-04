import 'package:flutter/material.dart';

class TugasFlutter1 extends StatelessWidget {
  const TugasFlutter1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil saya'),
        backgroundColor: const Color.fromARGB(255, 116, 146, 59),
      ),
      body: const Padding(
        padding: EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // Baris 1: Nama lengkap
            Text(
              'Nama : renal',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Memberikan jarak vertikal antar baris
            // Baris 2: Icon lokasi dan nama kota
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ), // Mengubah ikon jadi merah khas maps
                SizedBox(
                  width: 4,
                ), // Memberikan jarak horizontal antara ikon dan teks
                Text(
                  'Jakarta Manhatten',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 12), // Memberikan jarak vertikal sebelum deskripsi
            // Baris 3: Deskripsi singkat
            Text(
              'Seseorang yang sedang belajar pemrograman berbasiskan device dengan menggunakan flutter',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
