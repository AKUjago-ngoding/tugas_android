import 'package:flutter/material.dart';

/// Screen visualisasi dan output logika Looping Tugas 3
class Tugas03LoopingScreen extends StatelessWidget {
  const Tugas03LoopingScreen({super.key});

  static String runLoopingTasks() {
    final buffer = StringBuffer();

    buffer.writeln('===== SOAL 1: Bilangan Ganjil 1-20 =====');
    final ganjilList = <int>[];
    for (int i = 1; i <= 20; i += 2) {
      ganjilList.add(i);
    }
    buffer.writeln(ganjilList.join(', '));

    buffer.writeln('\n===== SOAL 2: Cetak Bintang 5x =====');
    buffer.writeln('* * * * *');

    buffer.writeln('\n===== SOAL 3: Nama Berulang (while loop 4x) =====');
    int count = 0;
    while (count < 4) {
      buffer.writeln('${count + 1}. Aisyah');
      count++;
    }

    buffer.writeln('\n===== SOAL 4: Loop List Buah (for-in) =====');
    const List<String> buah = ['Apel', 'Jeruk', 'Mangga', 'Anggur'];
    for (String item in buah) {
      buffer.writeln('Saya suka $item');
    }

    buffer.writeln('\n===== SOAL 5: Simulasi Daftar Belanja =====');
    const List<String> belanja = ['Beras', 'Minyak', 'Gula', 'Telur', 'Sabun'];
    for (int i = 0; i < belanja.length; i++) {
      buffer.writeln('Item ke-${i + 1}: ${belanja[i]}');
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final output = runLoopingTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 3: Algoritma Looping Dart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTaskCard(
            context,
            title: 'Soal 1: Bilangan Ganjil (1 - 20)',
            description: 'Perulangan angka ganjil menggunakan for loop.',
            resultWidget: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 1; i <= 20; i += 2)
                  Chip(
                    label: Text(
                      '$i',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.blue.shade50,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildTaskCard(
            context,
            title: 'Soal 2: Pola Bintang 5x',
            description: 'Mencetak baris karakter bintang.',
            resultWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.star, color: Colors.amber, size: 28),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildTaskCard(
            context,
            title: 'Soal 3: Nama Berulang (While Loop)',
            description: 'Mencetak string nama sebanyak 4 kali.',
            resultWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('Iteration ${i + 1}: Aisyah', style: const TextStyle(fontSize: 14)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildTaskCard(
            context,
            title: 'Soal 4 & 5: Iterasi List Buah & Belanja',
            description: 'Iterasi data koleksi menggunakan for-in dan index list.',
            resultWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('🍎 Apel, 🍊 Jeruk, 🥭 Mangga, 🍇 Anggur', style: TextStyle(fontSize: 14)),
                SizedBox(height: 6),
                Text('🛒 Keranjang: Beras, Minyak, Gula, Telur, Sabun', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Output Terminal
          Card(
            color: const Color(0xFF1E293B),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.terminal, color: Colors.greenAccent, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Full Dart Console Output',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 24),
                  Text(
                    output,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.lightGreenAccent,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget resultWidget,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            resultWidget,
          ],
        ),
      ),
    );
  }
}
