import 'package:flutter/material.dart';

class TugasFlutter3 extends StatelessWidget {
  const TugasFlutter3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> daftarLaporan = [
      "Kualitas Udara Baik - Jakarta Pusat",
      "Kualitas Udara Sedang - Jakarta Selatan",
      "Kualitas Udara Buruk - Jakarta Utara",
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Laporan & Riwayat Udara",
          style: TextStyle(
            color: Color.fromARGB(255, 217, 217, 217),
            fontSize: 25,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Color.fromARGB(239, 69, 88, 153),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Judul / Sub Title
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LAPORAN KONDISI UDARA",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // ListView
              Container(
                // form input text
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.map),
                          labelText: "Titik Lokasi (Nama Jalan / Gedung)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.air),
                          labelText: "Scor AQI Teramati",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Nama Pelapor",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.notes),
                          labelText: "Catatan Tambahan (Misal:Berkabut)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2.0, // Ketebalan garis
                height: 20.0, // Total ruang vertikal termasuk jarak atas-bawah
              ),
              Container(
                // List tile daftar Laporan
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daftarLaporan.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.air),
                        title: Text(daftarLaporan[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
