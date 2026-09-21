import 'package:flutter/material.dart';

/// Logika Dart Fundamental Tugas 1: Biodata Anggota Klub Buku
class Tugas01ConsoleScreen extends StatelessWidget {
  const Tugas01ConsoleScreen({super.key});

  static const String nama = 'JACK RAJA JAWA';
  static const int umur = 22;
  static const double tinggiBadan = 162.5;
  static const bool statusAktif = true;
  static const List<String> bukuFavorit = [
    'Laskar Pelangi',
    'Bumi Manusia',
    'Filosofi Teras',
  ];
  static const Map<String, String> informasiTambahan = {
    'alamat': 'Jl. Kenanga No. 10, Bandung',
    'profesi': 'Mahasiswa',
  };

  /// Fungsi helper yang menghasilkan output teks seperti di terminal console
  static String runLogic() {
    final buffer = StringBuffer();
    buffer.writeln('=== BIODATA ANGGOTA KLUB BUKU ===');
    buffer.writeln('Nama: $nama');
    buffer.writeln('Umur: $umur tahun');
    buffer.writeln('Tinggi Badan: $tinggiBadan cm');
    buffer.writeln('Status: ${statusAktif ? "Aktif" : "Tidak Aktif"}');
    buffer.writeln('\n--- Buku Favorit ---');
    for (var i = 0; i < bukuFavorit.length; i++) {
      buffer.writeln('${i + 1}. ${bukuFavorit[i]}');
    }
    buffer.writeln('\n--- Informasi Tambahan ---');
    informasiTambahan.forEach((k, v) {
      buffer.writeln('$k: $v');
    });
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 1: Biodata Klub Buku'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIODATA ANGGOTA',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'Nama', value: nama),
                  _InfoRow(label: 'Umur', value: '$umur tahun'),
                  _InfoRow(label: 'Tinggi Badan', value: '$tinggiBadan cm'),
                  _InfoRow(
                    label: 'Status Aktif',
                    value: statusAktif ? 'Aktif' : 'Tidak Aktif',
                    valueStyle: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Buku Favorit
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buku Favorit',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...bukuFavorit.map(
                    (judul) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.book,
                            size: 18,
                            color: Colors.indigo,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(judul)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Informasi Tambahan
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Tambahan',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...informasiTambahan.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.indigo,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${e.key}: ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(text: e.value),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _InfoRow({required this.label, required this.value, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}
