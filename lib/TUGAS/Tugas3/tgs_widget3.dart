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
              // Menggabungkan seluruh anak widget jadi 1 pembacaan ringkas
              Semantics(
                container: true,
                label: "Kartu Profil Budi", // HP cuma baca ini
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 138, 138, 138),
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/profile/bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Text(
                            "JACK RAJA JAWA",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: Row(
                    //   children: [
                    //     Image.asset(
                    //       'assets/profile/bg.png',
                    //       fit: BoxFit.cover,
                    //       height: 100,
                    //       width: 100,
                    //     ), // Otomatis dilewati
                    //     Icon(Icons.badge,size: 32), // Otomatis dilewati
                    //     SizedBox(width:8), // Otomatis dilewati
                    //     Container(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text('jabsdjbqdonoa',style: TextStyle(fontSize: 18)), // Otomatis dilewati // Otomatis dilewati
                    //           SizedBox(height: 4), // Otomatis dilewati
                    //           Text('Umur: 25 tahun',style: TextStyle(fontSize: 12)), // Otomatis dilewati
                    //           SizedBox(height: 2), // Otomatis dilewati
                    //           Text('Alamat: Jl. Merdeka No. 123',style: TextStyle(fontSize: 14)), // Otomatis dilewati
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
