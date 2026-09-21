import 'package:flutter/material.dart';

/// Screen interaktif untuk menguji logika penilaian kelulusan Tugas 2
class Tugas02LogicScreen extends StatefulWidget {
  const Tugas02LogicScreen({super.key});

  static String runCalculation({
    int uts = 85,
    int uas = 90,
    double kehadiran = 0.9,
  }) {
    final double rataRata = (uts + uas) / 2;
    final buffer = StringBuffer();
    buffer.writeln('=== PERHITUNGAN KELULUSAN MAHASISWA ===');
    buffer.writeln('Nilai UTS: $uts');
    buffer.writeln('Nilai UAS: $uas');
    buffer.writeln('Kehadiran: ${(kehadiran * 100).toStringAsFixed(0)}%');
    buffer.writeln('Rata-rata: ${rataRata.toStringAsFixed(1)}');
    buffer.writeln('---------------------------------------');

    final bool isLulus =
        rataRata >= 70 && kehadiran >= 0.75 && (uts >= 60 || uas >= 60);

    buffer.writeln('Syarat Kelulusan:');
    buffer.writeln('1. Rata-rata >= 70  : ${rataRata >= 70 ? "MEMENUHI" : "TIDAK"}');
    buffer.writeln('2. Kehadiran >= 75% : ${kehadiran >= 0.75 ? "MEMENUHI" : "TIDAK"}');
    buffer.writeln('3. UTS >= 60 / UAS >= 60 : ${(uts >= 60 || uas >= 60) ? "MEMENUHI" : "TIDAK"}');
    buffer.writeln('=======================================');
    buffer.writeln('Status Akhir: ${isLulus ? "LULUS 🎉" : "TIDAK LULUS ❌"}');
    return buffer.toString();
  }

  @override
  State<Tugas02LogicScreen> createState() => _Tugas02LogicScreenState();
}

class _Tugas02LogicScreenState extends State<Tugas02LogicScreen> {
  double _uts = 85;
  double _uas = 90;
  double _kehadiran = 90;

  @override
  Widget build(BuildContext context) {
    final output = Tugas02LogicScreen.runCalculation(
      uts: _uts.toInt(),
      uas: _uas.toInt(),
      kehadiran: _kehadiran / 100,
    );
    final double rataRata = (_uts + _uas) / 2;
    final bool isLulus =
        rataRata >= 70 && (_kehadiran / 100) >= 0.75 && (_uts >= 60 || _uas >= 60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 2: Kalkulator Kelulusan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Kontrol Input Interaktif
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uji Coba Nilai Mahasiswa',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Nilai UTS: ${_uts.toInt()}'),
                    Slider(
                      value: _uts,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _uts.toInt().toString(),
                      onChanged: (v) => setState(() => _uts = v),
                    ),
                    Text('Nilai UAS: ${_uas.toInt()}'),
                    Slider(
                      value: _uas,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _uas.toInt().toString(),
                      onChanged: (v) => setState(() => _uas = v),
                    ),
                    Text('Tingkat Kehadiran: ${_kehadiran.toInt()}%'),
                    Slider(
                      value: _kehadiran,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '${_kehadiran.toInt()}%',
                      onChanged: (v) => setState(() => _kehadiran = v),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLulus ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isLulus ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isLulus ? Icons.check_circle : Icons.cancel,
                    color: isLulus ? Colors.green : Colors.red,
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLulus ? 'Status: LULUS' : 'Status: TIDAK LULUS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLulus ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                        Text(
                          'Rata-rata: ${rataRata.toStringAsFixed(1)} | Kehadiran: ${_kehadiran.toInt()}%',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Console Output Terminal Card
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
                          'Dart Logic Terminal Output',
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
      ),
    );
  }
}
