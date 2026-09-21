import 'package:flutter/material.dart';

class LatArticleScreen extends StatelessWidget {
  const LatArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "EcoSync Article",
          style: TextStyle(
            color: Color(0xFF126839),
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/profile/qingxiao.jpg'),
              backgroundColor: Colors.black12,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "rinaldimulyatam@gmail.com",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.verified, size: 16, color: Colors.blue),
                    SizedBox(width: 4),
                    Text("Verified Author", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: const [
                Icon(Icons.circle, size: 12, color: Color(0xFF126839)),
                SizedBox(width: 6),
                Text(
                  "Innovation & Sustainability",
                  style: TextStyle(
                    color: Color(0xFF126839),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Masa Depan Energi Terbarukan: Inovasi EcoSync di Tahun 2024",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, height: 1.3),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.date_range_outlined, size: 16, color: Colors.black54),
                SizedBox(width: 6),
                Text(
                  "24 Mar 2024 • Oleh Admin EcoSync",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/G.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.green.shade100,
                  child: const Center(
                    child: Icon(Icons.eco, size: 64, color: Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Perkembangan teknologi energi terbarukan saat ini semakin pesat. EcoSync terus menghadirkan terobosan mutakhir dalam pengelolaan panel surya cerdas dan sistem penyimpanan baterai ramah lingkungan untuk menciptakan masa depan bumi yang lebih hijau, hemat energi, dan berkelanjutan bagi generasi mendatang.",
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
