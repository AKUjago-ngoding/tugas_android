import 'package:flutter/material.dart';
import 'widgets/registration_form.dart';
import 'widgets/report_card.dart';

// ponytail: daftar statis — ganti dengan API/Repository + loading/error state saat butuh data dinamis
const _reports = [
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Baik - Jakarta Pusat'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Jakarta Selatan'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Utara'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Utara'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Selatan'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Barat'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Utara'),
  Report(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Timur'),
];

class RevisiTugas4 extends StatelessWidget {
  const RevisiTugas4({super.key});

  @override
  Widget build(BuildContext context) {
    // AppBar style ambil dari Theme — bukan hardcode di widget
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Registrasi & Edukasi',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
        ),
        backgroundColor: const Color.fromARGB(239, 69, 88, 153),
      ),
      // SafeArea + CustomScrollView = standar enterprise (lazy sliver, bukan shrinkWrap)
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // — Header form
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Form Registrasi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),

            // — Form (state + validasi di widget terpisah)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: RegistrationForm(),
                  ),
                ),
              ),
            ),

            // — Divider
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Divider(thickness: 1.5),
              ),
            ),

            // — Section title laporan
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Daftar Laporan',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),

            // — Grid laporan (lazy, responsif, tanpa shrinkWrap)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                16 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ReportCard(report: _reports[i]),
                  childCount: _reports.length,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220, // responsif: 2 kolom HP, 3-4 tablet
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
