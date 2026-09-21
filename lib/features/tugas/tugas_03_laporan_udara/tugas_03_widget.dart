import 'package:flutter/material.dart';

class Tugas03Widget extends StatefulWidget {
  const Tugas03Widget({super.key});

  @override
  State<Tugas03Widget> createState() => _Tugas03WidgetState();
}

class _Tugas03WidgetState extends State<Tugas03Widget> {
  final List<String> daftarLaporan = [
    "Kualitas Udara Baik - Jakarta Pusat",
    "Kualitas Udara Sedang - Jakarta Selatan",
    "Kualitas Udara Buruk - Jakarta Utara",
  ];

  final _lokasiController = TextEditingController();
  final _aqiController = TextEditingController();
  final _pelaporController = TextEditingController();
  final _catatanController = TextEditingController();

  void _tambahLaporan() {
    if (_lokasiController.text.isNotEmpty && _aqiController.text.isNotEmpty) {
      setState(() {
        daftarLaporan.insert(
          0,
          "AQI ${_aqiController.text} (${_catatanController.text.isEmpty ? 'Kondisi Normal' : _catatanController.text}) - ${_lokasiController.text} oleh ${_pelaporController.text.isEmpty ? 'Anonim' : _pelaporController.text}",
        );
        _lokasiController.clear();
        _aqiController.clear();
        _pelaporController.clear();
        _catatanController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan berhasil ditambahkan!')),
      );
    }
  }

  @override
  void dispose() {
    _lokasiController.dispose();
    _aqiController.dispose();
    _pelaporController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Laporan & Riwayat Udara",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF455899),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "FORMULIR LAPORAN KONDISI UDARA",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Form Input
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                labelText: "Titik Lokasi (Nama Jalan / Gedung)",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _aqiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.air),
                labelText: "Skor AQI Teramati",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _pelaporController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: "Nama Pelapor",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _catatanController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.notes),
                labelText: "Catatan Tambahan (Misal: Berkabut)",
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahLaporan,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Simpan Laporan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF455899),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const Divider(height: 32, thickness: 1.5),

            // Daftar Riwayat Laporan
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Riwayat Laporan Terkini:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daftarLaporan.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.air, color: Colors.blue),
                    ),
                    title: Text(
                      daftarLaporan[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Kartu Profil Penanggung Jawab
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF455899),
                      child: Icon(Icons.badge, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Petugas Pengawas Lingkungan",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            "Rinaldi Mulyatama",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
