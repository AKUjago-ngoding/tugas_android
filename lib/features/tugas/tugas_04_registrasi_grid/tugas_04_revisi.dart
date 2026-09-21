import 'package:flutter/material.dart';
import 'models/report_item.dart';
import 'widgets/registration_form.dart';
import 'widgets/report_card.dart';

class Tugas04RevisiWidget extends StatelessWidget {
  const Tugas04RevisiWidget({super.key});

  static const List<ReportItem> _reports = [
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Baik - Jakarta Pusat'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Jakarta Selatan'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Utara'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Jakarta Barat'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Jakarta Timur'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Baik - Kepulauan Seribu'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Sedang - Tangerang Selatan'),
    ReportItem(image: 'assets/profile/bg.png', keterangan: 'Kualitas Udara Buruk - Bekasi Barat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tugas 4 (Revisi): Slivers Grid',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF455899),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header Form
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Form Registrasi Modern (Sliver Layout)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),

            // Form Box
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: RegistrationForm(),
                  ),
                ),
              ),
            ),

            // Divider
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Divider(thickness: 1.5),
              ),
            ),

            // Section Title
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Galeri Edukasi (Responsive SliverGrid)',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),

            // Responsive Lazy SliverGrid
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
                  maxCrossAxisExtent: 220,
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

