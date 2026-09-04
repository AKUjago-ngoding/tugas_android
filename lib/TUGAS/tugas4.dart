import 'package:flutter/material.dart';

class TugasFlutter4 extends StatelessWidget {
  const TugasFlutter4({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> daftarLaporan = [
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Baik - Jakarta Pusat",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Sedang - Jakarta Selatan",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      {
        "gambar": "assets/profile/bg.png",
        "keterangan": "Kualitas Udara Buruk - Jakarta Utara",
      },
      
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registrasi & Edukasi",
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
                      "Form Registrasi",
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
                          prefixIcon: Icon(Icons.person),
                          labelText: "Nama Pengguna",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email Pengguna",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Telephone Penggunan",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        obscureText: true, // Menyamarkan teks password
                        enableSuggestions:
                            false, // Mematikan saran teks di keyboard
                        autocorrect: false, // Mematikan koreksi otomatis
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: "Input Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        obscureText:
                            true, // Menyamarkan teks konfirmasi password
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "konfirmasi Password",
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: daftarLaporan.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              daftarLaporan[index]["gambar"]!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 1),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  daftarLaporan[index]["keterangan"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 6,
                              right: 6,
                              child: Icon(
                                Icons.access_alarm_sharp,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
