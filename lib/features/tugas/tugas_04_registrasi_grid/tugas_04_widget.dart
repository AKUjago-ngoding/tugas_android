import 'package:flutter/material.dart';
import 'models/report_item.dart';
import 'widgets/registration_form.dart';
import 'widgets/report_card.dart';

class Tugas04Widget extends StatelessWidget {
  const Tugas04Widget({super.key});

  static const List<ReportItem> daftarLaporan = [
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Baik - Jakarta Pusat'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Jakarta Selatan'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Utara'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Barat'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Jakarta Timur'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Baik - Kepulauan Seribu'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Registrasi & Edukasi",
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
              "Form Registrasi Relawan",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            const RegistrationForm(),
            const Divider(height: 32, thickness: 1.5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Galeri Edukasi & Pantauan Udara:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: daftarLaporan.length,
              itemBuilder: (context, index) {
                return ReportCard(report: daftarLaporan[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
